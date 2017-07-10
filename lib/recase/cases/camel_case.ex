defmodule Recase.CamelCase do
  @moduledoc """
  Module to convert strings to `camelCase`.

  This module should not be used directly.

  Read about `camelCase` here:
  https://en.wikipedia.org/wiki/Camel_case
  """

  import Recase.Replace

  @spec convert(String.t) :: String.t
  def convert(""), do: ""
  def convert(value) do
    value
    |> String.trim
    |> replace(~r/^[_\.\-\s]+/, "")
    |> replace(~r/([a-zA-Z]+)([A-Z][a-z\d]+)/, "\\1-\\2")
    |> String.downcase
    |> replace(~r/[_\.\-\s]+(\w|$)/, fn(_, x) -> String.upcase(x) end)
  end
end
