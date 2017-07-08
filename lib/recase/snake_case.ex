defmodule Recase.SnakeCase do
  @moduledoc """
  Documentation for Recase.
  """

  import Recase.Replace

  @sep "_"

  def convert(""), do: ""
  def convert(value) do
    value
    |> String.trim
    |> replace(~r/[\s_\.]/, @sep)
    |> replace(~r/([a-z\d])([A-Z])/, "\\1#{@sep}\\2")
    |> replace(~r/([A-Z]+)([A-Z][a-z\d]+)/, "\\1#{@sep}\\2")
    |> String.downcase
  end
end
