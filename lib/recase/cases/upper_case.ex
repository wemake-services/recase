defmodule Recase.UpperCase do
  @moduledoc """
  Module to convert strings to `UpperCase` aka `PascalCase`.

  This module should not be used directly.

  Read about `UpperCase` here:
  https://en.wikipedia.org/wiki/PascalCase
  """

  alias Recase.CamelCase

  @spec convert(String.t) :: String.t
  def convert(""), do: ""
  def convert(value) do
    <<char::binary-size(1), rest::binary>> = CamelCase.convert(value)
    String.upcase(char) <> rest
  end
end
