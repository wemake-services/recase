defmodule Recase.DotCase do
  @moduledoc """
  Module to convert strings to `dot.case`.

  This module should not be used directly.

  ## Examples

      iex> Recase.to_dot "foo_barBaz-λambdaΛambda-привет-Мир"
      "foo.bar.baz.λambda.λambda.привет.мир"

  `DotCase` is the same as `KebabCase` and `SnakeCase`.
  But uses `.` as a separator.
  """

  import Recase.Generic, only: [rejoin: 2]

  @sep "."

  @spec convert(String.t()) :: String.t()
  def convert(value) when is_binary(value),
    do: rejoin(value, separator: @sep, case: :down)
end
