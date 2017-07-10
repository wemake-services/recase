defmodule Recase.PathCase do
  @moduledoc """
  Module to convert strings to `path/case`.

  This module should not be used directly.

  Path case preserves the original case,
  but inserts path separator to appropriate places.

  By default uses `/` as a path separator.
  """

  import Recase.Replace

  @sep "/"

  @spec convert(String.t) :: String.t
  def convert(value, separator \\ @sep)
  def convert("", _), do: ""
  def convert(value, separator) do
    value
    |> String.trim
    |> replace(~r/[\s\.\-_]/, separator)
    |> replace(~r/([a-z\d])([A-Z])/, "\\1#{separator}\\2")
    |> replace(~r/([A-Z]+)([A-Z][a-z\d]+)/, "\\1#{separator}\\2")
  end
end
