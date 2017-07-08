defmodule Recase.Replace do
  @moduledoc """
  Documentation for Recase.
  """

  def replace(value, regex, new_value) do
    Regex.replace(regex, value, new_value)
  end
end
