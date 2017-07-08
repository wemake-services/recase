defmodule Recase.CamelCase do
  @moduledoc """
  Documentation for Recase.
  """

  import Recase.Replace

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
