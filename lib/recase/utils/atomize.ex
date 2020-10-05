defmodule Recase.Atomize do
  @moduledoc """
  Helper module to convert strings to atoms.
  """

  @doc """
  Atomizes a string value.
  Uses an existing atom if possible.
  """
  @spec safe_atom(String.t()) :: atom()
  def safe_atom(string_value) do
    try do
      String.to_existing_atom(string_value)
   rescue
       ArgumentError -> String.to_atom(string_value)
   end
  end
end
