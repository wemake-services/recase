defmodule Recase do
  @moduledoc """
  Recase allows you to convert string from any to any case.

  This module contains public interface.
  """

  alias Recase.{
    CamelCase,
    UpperCase,
    SnakeCase,
    KebabCase,
    ConstantCase,
    PathCase,
    DotCase
  }

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

  @doc """
  Converts string to CONSTANT_CASE.

  ## Examples

      iex> Recase.to_constant("SomeValue")
      "SOME_VALUE"

      iex> Recase.to_constant("some value")
      "SOME_VALUE"
  """
  @spec to_constant(String.t) :: String.t
  def to_constant(value), do: ConstantCase.convert(value)

  @doc ~S"""
  Converts string to path/case.

  ## Examples

      iex> Recase.to_path("SomeValue")
      "Some/Value"

      iex> Recase.to_path("some value", "\\")
      "some\\value"
  """
  @spec to_path(String.t, String.t) :: String.t
  def to_path(value, separator), do: PathCase.convert(value, separator)
  @spec to_path(String.t) :: String.t
  def to_path(value), do: PathCase.convert(value)

  @doc """
  Converts string to dot.case

  ## Examples

      iex> Recase.to_dot("SomeValue")
      "some.value"

      iex> Recase.to_dot("some value")
      "some.value"
  """
  @spec to_dot(String.t) :: String.t
  def to_dot(value), do: DotCase.convert(value)
end
