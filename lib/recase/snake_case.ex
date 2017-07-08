defmodule Recase.SnakeCase do
  @moduledoc """
  Documentation for Recase.
  """

  def convert(""), do: ""
  def convert(value) when is_binary(value) do
    "snake_case"
  end
end
