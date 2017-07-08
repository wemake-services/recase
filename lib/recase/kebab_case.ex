defmodule Recase.KebabCase do
  @moduledoc """
  Documentation for Recase.
  """

  def convert(""), do: ""
  def convert(value) when is_binary(value) do
    "kebab-case"
  end
end
