defmodule Recase.DotCase do
  @moduledoc """
  Module to convert strings to `dot.case`.

  This module should not be used directly.

  `DotCase` is the same as `KebabCase` and `SnakeCase`.
  But uses `.` as a separator.
  """

  alias Recase.SnakeCase

  @sep "."

  @spec convert(String.t) :: String.t
  def convert(value) do
    value
    |> SnakeCase.convert
    |> String.replace("_", @sep)
  end
end
