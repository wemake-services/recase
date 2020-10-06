defmodule Recase.Generic do
  @moduledoc """
  Generic module to split and join strings back or convert strings to atoms.
  This module should not be used directly.
  """

  @splitters Application.get_env(:recase, :delimiters, [
               ?\s,
               ?\n,
               ?\t,
               ?_,
               ?.,
               ?-,
               ?#,
               ??,
               ?!
             ])

  @delimiters (case @splitters do
                 list when is_list(list) ->
                   list

                 :symbol ->
                   [all, digits, down, up] =
                     Enum.map(
                       [32..127, ?0..?9, ?a..?z, ?A..?Z],
                       &Enum.to_list/1
                     )

                   all -- (digits ++ down ++ up)
               end)

  @doc """
  Splits the input into **`list`**. Utility function.
  ## Examples
      iex> Recase.Generic.split "foo_barBaz-λambdaΛambda-привет-Мир"
      ["foo", "bar", "Baz", "λambda", "Λambda", "привет", "Мир"]
  """
  @spec split(input :: String.t()) :: [String.t()]
  def split(input) when is_binary(input), do: do_split(input)

  @doc """
  Splits the input and **`rejoins`** it with a separator given. Optionally
  converts parts to `downcase`, `upcase` or `titlecase`.
  - `opts[:case] :: [:down | :up | :title | :none]`
  - `opts[:separator] :: binary() | integer()`
  Default separator is `?_`, default conversion is `:downcase` so that
  it behaves the same way as `to_snake/1`.
  ## Examples
      iex> Recase.Generic.rejoin "foo_barBaz-λambdaΛambda-привет-Мир", separator: "__"
      "foo__bar__baz__λambda__λambda__привет__мир"
  """
  @spec rejoin(input :: String.t(), opts :: Keyword.t()) :: String.t()
  def rejoin(input, opts \\ []) when is_binary(input) do
    mapper =
      case Keyword.get(opts, :case, :down) do
        :down ->
          &String.downcase/1

        :title ->
          fn <<char::utf8, rest::binary>> ->
            String.upcase(<<char::utf8>>) <> String.downcase(rest)
          end

        :up ->
          &String.upcase/1

        _ ->
          & &1
      end

    input
    |> do_split()
    |> Enum.map(mapper)
    |> Enum.join(Keyword.get(opts, :separator, ?_))
  end

  @doc """
  Atomizes a string value.
  Uses an existing atom if possible.
  """
  @spec safe_atom(String.t()) :: atom()
  def safe_atom(string_value) do
    String.to_existing_atom(string_value)
  rescue
    ArgumentError -> String.to_atom(string_value)
  end

  ##############################################################################

  @spec do_split(input :: String.t(), {binary(), acc :: [String.t()]}) :: [
          String.t()
        ]
  defp do_split(string, acc \\ {"", []})

  defp do_split("", {"", acc}), do: Enum.reverse(acc)

  defp do_split("", {curr, acc}),
    do: do_split("", {"", [curr | acc]})

  Enum.each(@delimiters, fn delim ->
    defp do_split(<<unquote(delim)::utf8, rest::binary>>, {"", acc}),
      do: do_split(rest, {"", acc})

    defp do_split(<<unquote(delim), rest::binary>>, {curr, acc}),
      do: do_split(rest, {"", [curr | acc]})
  end)

  Enum.each(?A..?Z, fn char ->
    defp do_split(<<unquote(char), rest::binary>>, {"", acc}),
      do: do_split(rest, {<<unquote(char)::utf8>>, acc})

    defp do_split(<<unquote(char), rest::binary>>, {curr, acc}) do
      <<c::utf8, _::binary>> = String.reverse(curr)

      if c in ?A..?Z do
        do_split(rest, {curr <> <<unquote(char)::utf8>>, acc})
      else
        do_split(rest, {<<unquote(char)::utf8>>, [curr | acc]})
      end
    end
  end)

  [32..64, 91..127]
  |> Enum.map(&Enum.to_list/1)
  |> Enum.reduce(&Kernel.++/2)
  |> Kernel.--(@delimiters)
  |> Enum.each(fn char ->
    defp do_split(<<unquote(char)::utf8, rest::binary>>, {"", acc}),
      do: do_split(rest, {<<unquote(char)::utf8>>, acc})

    defp do_split(<<unquote(char), rest::binary>>, {curr, acc}),
      do: do_split(rest, {curr <> <<unquote(char)::utf8>>, acc})
  end)

  defp do_split(<<char::utf8, rest::binary>>, {"", acc}),
    do: do_split(rest, {<<char::utf8>>, acc})

  @upcase ~r/(?<!\p{Lu})\p{Lu}/u

  defp do_split(<<char::utf8, rest::binary>>, {curr, acc}) do
    if Regex.match?(@upcase, <<char::utf8>>) do
      do_split(rest, {<<char::utf8>>, [curr | acc]})
    else
      do_split(rest, {curr <> <<char::utf8>>, acc})
    end
  end
end
