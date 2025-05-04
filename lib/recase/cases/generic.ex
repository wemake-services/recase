defmodule Recase.Generic do
  @moduledoc """
  Generic module to split and join strings back or convert strings to atoms.
  This module should not be used directly.
  """

  @splitters Application.compile_env(:recase, :delimiters, [
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
    |> split()
    |> Enum.map_join(Keyword.get(opts, :separator, ?_), mapper)
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

  defp do_split(string) do
    is_all_upcase = String.upcase(string) == string
    acc = {"", []}
    meta = %{is_all_upcase: is_all_upcase}

    do_split_r(string, acc, meta)
  end

  @spec do_split_r(
          input :: String.t(),
          {binary(), acc :: [String.t()]},
          meta :: %{is_all_upcase: boolean()}
        ) :: [
          String.t()
        ]
  defp do_split_r(string, acc, meta)

  defp do_split_r("", {"", acc}, _meta), do: Enum.reverse(acc)

  defp do_split_r("", {curr, acc}, meta),
    do: do_split_r("", {"", [curr | acc]}, meta)

  Enum.each(@delimiters, fn delim ->
    defp do_split_r(<<unquote(delim)::utf8, rest::binary>>, {"", acc}, meta),
      do: do_split_r(rest, {"", acc}, meta)

    defp do_split_r(<<unquote(delim), rest::binary>>, {curr, acc}, meta),
      do: do_split_r(rest, {"", [curr | acc]}, meta)
  end)

  Enum.each(?A..?Z, fn char ->
    defp do_split_r(
           <<unquote(char), rest::binary>>,
           {curr, acc},
           %{
             is_all_upcase: true
           } = meta
         ) do
      do_split_r(rest, {curr <> <<unquote(char)::utf8>>, acc}, meta)
    end

    defp do_split_r(<<unquote(char), _::binary>> = input, {"", acc}, meta) do
      {upcase_streak, rest} = upcase_streak(input, "")

      case byte_size(upcase_streak) do
        1 ->
          do_split_r(rest, {<<unquote(char)::utf8>>, acc}, meta)

        2 ->
          <<c1::utf8, c2::utf8>> = upcase_streak
          do_split_r(rest, {<<c2::utf8>>, [<<c1::utf8>> | acc]}, meta)

        _ ->
          do_split_r(rest, {<<upcase_streak::binary>>, acc}, meta)
      end
    end
  end)

  [32..64, 91..127]
  |> Enum.map(&Enum.to_list/1)
  |> Enum.reduce(&Kernel.++/2)
  |> Kernel.--(@delimiters)
  |> Enum.each(fn char ->
    defp do_split_r(<<unquote(char)::utf8, rest::binary>>, {"", acc}, meta),
      do: do_split_r(rest, {<<unquote(char)::utf8>>, acc}, meta)

    defp do_split_r(<<unquote(char), rest::binary>>, {curr, acc}, meta),
      do: do_split_r(rest, {curr <> <<unquote(char)::utf8>>, acc}, meta)
  end)

  defp do_split_r(<<char::utf8, rest::binary>>, {"", acc}, meta),
    do: do_split_r(rest, {<<char::utf8>>, acc}, meta)

  @upcase ~r/(?<!\p{Lu})\p{Lu}/u

  defp do_split_r(<<char::utf8, rest::binary>>, {curr, acc}, meta) do
    if Regex.match?(@upcase, <<char::utf8>>) do
      do_split_r(rest, {<<char::utf8>>, [curr | acc]}, meta)
    else
      do_split_r(rest, {curr <> <<char::utf8>>, acc}, meta)
    end
  end

  Enum.each(?A..?Z, fn char ->
    defp upcase_streak(<<unquote(char), rest::binary>>, curr),
      do: upcase_streak(rest, curr <> <<unquote(char)::utf8>>)
  end)

  defp upcase_streak(rest, upcase_streak), do: {upcase_streak, rest}
end
