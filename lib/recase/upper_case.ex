defmodule Recase.UpperCase do
  @moduledoc """
  Documentation for Recase.
  """

  alias Recase.CamelCase

  def convert(""), do: ""
  def convert(value) do
    <<char::binary-size(1), rest::binary>>  = CamelCase.convert(value)
    String.upcase(char) <> rest
  end
end
