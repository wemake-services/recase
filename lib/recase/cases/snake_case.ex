defmodule Recase.SnakeCase do
  @moduledoc """
  Module to convert strings to `snake_case`.

  This module should not be used directly.

  Read about `snake_case` here:
  https://en.wikipedia.org/wiki/Snake_case
  """

  import Recase.Replace

  @sep "_"

  @spec convert(String.t) :: String.t
  def convert(""), do: ""
  def convert(value) do
    value
    |> String.split(~r/[^a-zA-Z0-9]+/)
    |> Enum.map(fn(word) ->
      word
      |> replace(~r/[\s\.\-]/, @sep)
      |> replace(~r/([a-z\d])([A-Z])/, "\\1#{@sep}\\2")
      |> replace(~r/([A-Z]+)([A-Z][a-z\d]+)/, "\\1#{@sep}\\2")
      end)
    |> Enum.join(@sep)
    |> String.downcase
    |> String.trim(@sep)
  end
end
