defmodule Recase.PascalCase do
  @moduledoc """
  Module to convert strings to `PascalCase` aka `UpperCase`.

  This module should not be used directly.

  ## Examples

      iex> Recase.to_pascal "foo_barBaz-λambdaΛambda-привет-Мир"
      "FooBarBazΛambdaΛambdaПриветМир"

  Read about `PascalCase` here:
  https://en.wikipedia.org/wiki/PascalCase

  ## Changed

  This name was introduced in version `0.2.0`,
  it was named `UpperCase` before.

  But `UpperCase` was not clear enough. What is `uppercase`?

  1. THIS IS UPPERCASE
  2. ThisIsAlsoUpperCase

  So, it was decided to rename this module into `PascalCase`.
  For other details see: https://github.com/sobolevn/recase/issues/2
  """

  import Recase.Generic, only: [rejoin: 2]

  @spec convert(String.t()) :: String.t()
  def convert(value) when is_binary(value),
    do: rejoin(value, separator: "", case: :title)

  @spec convert(atom()) :: atom()
  def convert(value) when is_atom(value),
    do: convert(Atom.to_string(value)) |> Recase.Generic.safe_atom()
end
