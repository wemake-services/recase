defmodule Recase.ConstantCase do
  @moduledoc """
  Module to convert strings to `CONSTANT_CASE`.

  This module should not be used directly.

  ## Examples

      iex> Recase.to_constant "foo_barBaz-λambdaΛambda-привет-Мир"
      "FOO_BAR_BAZ_ΛAMBDA_ΛAMBDA_ПРИВЕТ_МИР"

  Constant case is the same as `snake_case`,
  but uppercased.
  """

  import Recase.Generic, only: [rejoin: 2]

  @spec convert(String.t()) :: String.t()
  def convert(value) when is_binary(value),
    do: rejoin(value, separator: "_", case: :up)

  @spec convert(atom()) :: atom()
  def convert(value) when is_atom(value),
    do: convert(Atom.to_string(value)) |> Recase.Generic.safe_atom()
end
