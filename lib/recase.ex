defmodule Recase do
  @moduledoc """
  Recase allows you to convert string from any to any case.

  This module contains public interface.
  """

  alias Recase.{CamelCase, UpperCase, SnakeCase, KebabCase}

  @doc """
  Converts string to UpperCase aka PascalCase.

  ## Examples

      iex> Recase.to_upper("some-value")
      "SomeValue"

      iex> Recase.to_upper("some value")
      "SomeValue"
  """
  @spec to_upper(String.t) :: String.t
  def to_upper(value), do: UpperCase.convert(value)

  @doc """
  Converts string to camelCase.

  ## Examples

      iex> Recase.to_camel("some-value")
      "someValue"

      iex> Recase.to_camel("Some Value")
      "someValue"
  """
  @spec to_camel(String.t) :: String.t
  def to_camel(value), do: CamelCase.convert(value)

  @doc """
  Converts string to snake_case.

  ## Examples

      iex> Recase.to_snake("some-value")
      "some_value"

      iex> Recase.to_snake("someValue")
      "some_value"
  """
  @spec to_snake(String.t) :: String.t
  def to_snake(value), do: SnakeCase.convert(value)

  @doc """
  Converts string to kebab-case.

  ## Examples

      iex> Recase.to_kebab("SomeValue")
      "some-value"

      iex> Recase.to_kebab("some value")
      "some-value"
  """
  @spec to_kebab(String.t) :: String.t
  def to_kebab(value), do: KebabCase.convert(value)
end
