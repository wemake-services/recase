defmodule Recase.CamelCase do
  @moduledoc """
  Module to convert strings to `camelCase`.

  This module should not be used directly.

  ## Examples

      iex> Recase.to_camel "foo_barBaz-λambdaΛambda-привет-Мир"
      "fooBarBazΛambdaΛambdaПриветМир"

  Read about `camelCase` here:
  https://en.wikipedia.org/wiki/Camel_case
  """

  import Recase.Generic, only: [rejoin: 2]

  @spec convert(String.t()) :: String.t()
  def convert(""), do: ""

  def convert(value) when is_binary(value) do
    with <<char::utf8, rest::binary>> <-
           rejoin(value, separator: "", case: :title),
         do: String.downcase(<<char::utf8>>) <> rest
  end

  @spec convert(atom()) :: atom()
  def convert(value) when is_atom(value),
    do: convert(Atom.to_string(value)) |> Recase.Generic.safe_atom()
end
