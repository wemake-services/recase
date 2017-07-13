defmodule Recase.ConstantCase do
  @moduledoc """
  Module to convert strings to `CONSTANT_CASE`.

  This module should not be used directly.

  Constant case is the same as `snake_case`,
  but uppercased.
  """

  alias Recase.SnakeCase

  @spec convert(String.t) :: String.t
  def convert(value) do
    value
    |> SnakeCase.convert
    |> String.upcase
  end
end
