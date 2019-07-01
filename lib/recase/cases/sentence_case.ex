defmodule Recase.SentenceCase do
  @moduledoc """
  Module to convert strings to `Sentence case`.

  This module should not be used directly.

  ## Examples

      iex> Recase.to_sentence "foo_barBaz-λambdaΛambda-привет-Мир"
      "Foo bar baz λambda λambda привет мир"

  Read about `Sentence case` here:
  https://en.wikipedia.org/wiki/Letter_case#Sentence_case
  """

  import Recase.Generic, only: [rejoin: 2]

  @sep " "

  @spec convert(String.t()) :: String.t()
  def convert(value) when is_binary(value) do
    with <<char::utf8, rest::binary>> <-
           rejoin(value, separator: @sep, case: :down),
         do: String.upcase(<<char::utf8>>) <> rest
  end
end
