defmodule Recase do
  @moduledoc """
  Recase allows you to convert string from any to any case.

  This module contains public interface.
  """

  alias Recase.{
    CamelCase,
    ConstantCase,
    DotCase,
    HeaderCase,
    KebabCase,
    NameCase,
    PascalCase,
    PathCase,
    SentenceCase,
    SnakeCase,
    TitleCase
  }

  @doc """
  Converts string to PascalCase (aka UpperCase).

  ## Examples

      iex> Recase.to_pascal("some-value")
      "SomeValue"

      iex> Recase.to_pascal("some value")
      "SomeValue"
  """
  @spec to_pascal(String.t()) :: String.t()
  def to_pascal(value), do: PascalCase.convert(value)

  @doc """
  Converts string to camelCase.

  ## Examples

      iex> Recase.to_camel("some-value")
      "someValue"

      iex> Recase.to_camel("Some Value")
      "someValue"
  """
  @spec to_camel(String.t()) :: String.t()
  def to_camel(value), do: CamelCase.convert(value)

  @doc """
  Converts string to snake_case.

  ## Examples

      iex> Recase.to_snake("some-value")
      "some_value"

      iex> Recase.to_snake("someValue")
      "some_value"
  """
  @spec to_snake(String.t()) :: String.t()
  def to_snake(value), do: SnakeCase.convert(value)
  defdelegate underscore(value), to: Recase, as: :to_snake

  @doc """
  Converts string to kebab-case.

  ## Examples

      iex> Recase.to_kebab("SomeValue")
      "some-value"

      iex> Recase.to_kebab("some value")
      "some-value"
  """
  @spec to_kebab(String.t()) :: String.t()
  def to_kebab(value), do: KebabCase.convert(value)

  @doc """
  Converts string to CONSTANT_CASE.

  ## Examples

      iex> Recase.to_constant("SomeValue")
      "SOME_VALUE"

      iex> Recase.to_constant("some value")
      "SOME_VALUE"
  """
  @spec to_constant(String.t()) :: String.t()
  def to_constant(value), do: ConstantCase.convert(value)

  @doc ~S"""
  Converts string to path/case.

  ## Examples

      iex> Recase.to_path("SomeValue")
      "Some/Value"

      iex> Recase.to_path("some value", "\\")
      "some\\value"
  """
  @spec to_path(String.t(), String.t()) :: String.t()
  def to_path(value, separator), do: PathCase.convert(value, separator)
  @spec to_path(String.t()) :: String.t()
  def to_path(value), do: PathCase.convert(value)

  @doc """
  Converts string to dot.case

  ## Examples

      iex> Recase.to_dot("SomeValue")
      "some.value"

      iex> Recase.to_dot("some value")
      "some.value"
  """
  @spec to_dot(String.t()) :: String.t()
  def to_dot(value), do: DotCase.convert(value)

  @doc """
  Converts string to Sentence case

  ## Examples

      iex> Recase.to_sentence("SomeValue")
      "Some value"

      iex> Recase.to_sentence("some value")
      "Some value"
  """
  @spec to_sentence(String.t()) :: String.t()
  def to_sentence(value), do: SentenceCase.convert(value)

  @doc """
  Converts string to Title Case

  ## Examples

      iex> Recase.to_title("SomeValue")
      "Some Value"

      iex> Recase.to_title("some value")
      "Some Value"
  """
  @spec to_title(String.t()) :: String.t()
  def to_title(value), do: TitleCase.convert(value)

  @doc """
  Converts string to Header-Case

  ## Examples

  iex> Recase.to_header("SomeValue")
  "Some-Value"

  iex> Recase.to_header("some value")
  "Some-Value"
  """
  @spec to_header(String.t()) :: String.t()
  def to_header(value), do: HeaderCase.convert(value)

  @doc """
  Converts string to Name Case

  ## Examples

  iex> Recase.to_name("mccarthy o'donnell")
  "McCarthy O'Donnell"

  iex> Recase.to_name("von streit")
  "von Streit"
  """
  @spec to_name(String.t()) :: String.t()
  def to_name(value), do: NameCase.convert(value)
end
