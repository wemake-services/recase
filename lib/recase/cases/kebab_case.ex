defmodule Recase.KebabCase do
  @moduledoc """
  Module to convert strings to `kebab-case`.

  This module should not be used directly.

  Read about `kebab-case` here:
  https://en.wikipedia.org/wiki/Kebab_case
  """

  alias Recase.SnakeCase

  @sep "-"

  @spec convert(String.t) :: String.t
  def convert(value) do
    value
    |> SnakeCase.convert
    |> String.replace("_", @sep)
  end
end
