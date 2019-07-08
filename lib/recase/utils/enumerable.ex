defmodule Recase.Enumerable do
  @moduledoc """
  Helper module to convert enumerable keys recursively.
  """

  @doc """
  Invoke fun for each keys of the enumerable.
  """
  @spec convert_keys(Enumerable.t(), fun) :: Enumerable.t()
  def convert_keys(enumerable, fun) when is_map(enumerable) do
    enumerable
    |> Enum.into(%{}, fn {key, value} ->
      {fun.(key), handle_value(value, fun)}
    end)
  end

  def convert_keys(enumerable, fun) when is_list(enumerable) do
    enumerable
    |> Enum.map(&handle_value(&1, fun))
  end

  defp handle_value(value, fun) when is_map(value) or is_list(value) do
    convert_keys(value, fun)
  end

  defp handle_value(value, _), do: value
end
