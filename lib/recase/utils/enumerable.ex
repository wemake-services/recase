defmodule Recase.Enumerable do
  @moduledoc """
  Helper module to convert enumerable keys recursively.
  """

  @doc """
  Invoke fun for each keys of the enumerable and cast keys to atoms.
  """
  @spec atomize_keys(Enumerable.t(), fun) :: Enumerable.t()
  def atomize_keys(enumerable, fun \\ fn x -> x end)

  def atomize_keys(enumerable, fun) when is_map(enumerable) do
    enumerable
    |> Enum.into(%{}, fn {key, value} ->
      atom_key =
        key
        |> cast_string()
        |> fun.()
        |> cast_atom()

      {atom_key, handle_value(value, fun, &atomize_keys/2)}
    end)
  end

  def atomize_keys(enumerable, fun)
      when is_list(enumerable) do
    enumerable
    |> Enum.map(fn value -> handle_value(value, fun, &atomize_keys/2) end)
  end

  @spec stringify_keys(Enumerable.t(), fun) :: Enumerable.t()
  def stringify_keys(enumerable, fun \\ fn x -> x end)

  def stringify_keys(enumerable, fun)
      when is_map(enumerable) do
    enumerable
    |> Enum.into(%{}, fn {key, value} ->
      string_key =
        key
        |> cast_string()
        |> fun.()

      {string_key, handle_value(value, fun, &stringify_keys/2)}
    end)
  end

  def stringify_keys(enumerable, fun)
      when is_list(enumerable) do
    enumerable
    |> Enum.map(fn value -> handle_value(value, fun, &stringify_keys/2) end)
  end

  @doc """
  Invoke fun for each keys of the enumerable.
  """
  @spec convert_keys(Enumerable.t(), fun) :: Enumerable.t()
  def convert_keys(enumerable, fun \\ fn x -> x end)

  def convert_keys(enumerable, fun) when is_map(enumerable) do
    enumerable
    |> Enum.into(%{}, fn {key, value} ->
      {fun.(key), handle_value(value, fun, &convert_keys/2)}
    end)
  end

  def convert_keys(enumerable, fun)
      when is_list(enumerable) do
    enumerable
    |> Enum.map(fn value -> handle_value(value, fun, &convert_keys/2) end)
  end

  defp handle_value(value, fun, converter)
       when is_map(value) or is_list(value) do
    converter.(value, fun)
  end

  defp handle_value(value, _, _), do: value

  defp cast_string(value) when is_binary(value), do: value

  defp cast_string(value) when is_atom(value), do: Atom.to_string(value)

  defp cast_atom(value), do: String.to_atom(value)
end
