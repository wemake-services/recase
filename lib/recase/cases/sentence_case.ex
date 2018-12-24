defmodule Recase.SentenceCase do
    @moduledoc """
    Module to convert strings to `Sentence case`.
  
    This module should not be used directly.
  
    Read about `Sentence case` here:
    https://en.wikipedia.org/wiki/Letter_case#Sentence_case
    """

    alias Recase.SnakeCase

    @sep " "

    @spec convert(String.t) :: String.t
    def convert(""), do: ""
    def convert(value) do
      value
      |> SnakeCase.convert
      |> String.replace("_", @sep)
      |> String.capitalize
    end
  end
