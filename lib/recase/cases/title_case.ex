defmodule Recase.TitleCase do
    @moduledoc """
    Module to convert strings to `Title Case`.
  
    This module should not be used directly.
  
    Read about `Title Case` here:
    https://en.wikipedia.org/wiki/Letter_case#Title_case
    """

    alias Recase.SnakeCase

    @sep " "

    @spec convert(String.t) :: String.t
    def convert(""), do: ""
    def convert(value) do
      value
      |> SnakeCase.convert
      |> String.replace("_", @sep)
      |> String.split()
      |> Enum.map(&(String.capitalize(&1)))
      |> Enum.join(@sep)
    end
  end
