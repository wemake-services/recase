defmodule Recase.PascalCase do
  @moduledoc """
  Module to convert strings to `PascalCase` aka `UpperCase`.

  This module should not be used directly.

  Read about `PascalCase` here:
  https://en.wikipedia.org/wiki/PascalCase

  ## Changed

  This name was introduced in version `0.2.0`,
  it was named `UpperCase` before.

  But `UpperCase` was not clear enough. What is `uppercase`?

  1. THIS IS UPPERCASE
  2. ThisIsAlsoUpperCase

  So, it was decided to rename this module into `PascalCase`.
  For other details see: https://github.com/sobolevn/recase/issues/2
  """

  alias Recase.CamelCase

  @spec convert(String.t) :: String.t
  def convert(""), do: ""
  def convert(value) do
    <<char::binary-size(1), rest::binary>> = CamelCase.convert(value)
    String.upcase(char) <> rest
  end
end
