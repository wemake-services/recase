defmodule Recase.UpperCase do
  @moduledoc """
  Documentation for Recase.
  """

  def convert(""), do: ""
  def convert(value) when is_binary(value) do
    "UpperCase"
  end
end
