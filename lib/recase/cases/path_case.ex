defmodule Recase.PathCase do
  @moduledoc """
  Module to convert strings to `path/case`.

  This module should not be used directly.

  Path case preserves the original case,
  but inserts path separator to appropriate places.

  By default uses `/` as a path separator.

  ## Examples

      iex> Recase.to_path "foo_barBaz-λambdaΛambda-привет-Мир"
      "foo/bar/Baz/λambda/Λambda/привет/Мир"
  """

  import Recase.Generic, only: [rejoin: 2]

  @sep "/"

  @spec convert(String.t(), String.t()) :: String.t()
  def convert(value, separator \\ @sep)

  def convert(<<separator::binary-size(1), rest::binary>>, separator),
    do: separator <> convert(rest, separator)

  def convert(value, separator) when is_binary(value),
    do: rejoin(value, separator: separator, case: :none)
end
