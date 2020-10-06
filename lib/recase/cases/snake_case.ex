defmodule Recase.SnakeCase do
  @moduledoc """
  Module to convert strings to `snake_case`.

  This module should not be used directly.

  ## Examples

      iex> Recase.to_snake "foo_barBaz-λambdaΛambda-привет-Мир"
      "foo_bar_baz_λambda_λambda_привет_мир"
      iex> Recase.underscore "foo_barBaz-λambdaΛambda-привет-Мир"
      "foo_bar_baz_λambda_λambda_привет_мир"

  Read about `snake_case` here:
  https://en.wikipedia.org/wiki/Snake_case
  """

  import Recase.Generic, only: [rejoin: 2]

  @sep "_"

  @spec convert(String.t()) :: String.t()
  def convert(value) when is_binary(value),
    do: rejoin(value, separator: @sep, case: :down)

  @spec convert(atom()) :: atom()
  def convert(value) when is_atom(value),
    do: convert(Atom.to_string(value)) |> Recase.Generic.safe_atom()
end
