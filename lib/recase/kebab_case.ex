defmodule Recase.KebabCase do
  @moduledoc """
  Documentation for Recase.
  """

  alias Recase.SnakeCase

  @sep "-"

  def convert(value) do
    value
    |> SnakeCase.convert
    |> String.replace("_", @sep)
  end
end
