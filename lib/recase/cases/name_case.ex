defmodule Recase.NameCase do
  @moduledoc """
  Module to convert strings to `Name Case`.

  This module should not be used directly.

  ## Examples

      iex> Recase.to_name "mccarthy o'donnell"
      "McCarthy O'Donnell"

  Read about `Name Case` here:
  https://metacpan.org/pod/Lingua::EN::NameCase
  """
  import Recase.Replace

  @spec convert(String.t()) :: String.t()
  def convert(value) when is_binary(value) do
    value
    |> String.downcase()
    |> replace(~r|\b\w|, fn first_char_of_word ->
      String.upcase(first_char_of_word)
    end)
    |> replace(~r|\'\w\b|, fn apostophe_ess ->
      String.downcase(apostophe_ess)
    end)
    |> replace_irish()
    |> replace(~r|\bVon\b|, "von")
    |> replace(~r|\bVan(?=\s+\w)|, "van")
    |> replace(~r|\bAp\b|, "ap")
    |> replace(~r|\bAl(?=\s+\w)|, "al")
    |> replace(~r|\bEl\b|, "el")
    |> replace(~r|\bLa\b|, "la")
    |> replace(~r|\bBen(?=\s+\w)|, "ben")
    |> replace(~r/\b(Bin|Binti|Binte)\b/, fn bin_prefix ->
      String.downcase(bin_prefix)
    end)
    |> replace(~r|\bD([aeiou])\b|, fn da_prefix ->
      String.downcase(da_prefix)
    end)
    |> replace(~r|\bD([ao]s)\b|, fn das_prefix ->
      String.downcase(das_prefix)
    end)
    |> replace(~r|\bDell([ae])\b|, fn dell_prefix ->
      String.downcase(dell_prefix)
    end)
    |> replace(~r|\bDe([lr])\b|, fn del_prefix ->
      String.downcase(del_prefix)
    end)
    |> replace(~r|\bL([eo])\b|, fn le_prefix -> String.downcase(le_prefix) end)
    |> replace_roman_numerals()
    |> replace(~r|\b([YEI])\b|, fn conjunction ->
      String.downcase(conjunction)
    end)
  end

  defp replace_roman_numerals(string) do
    replace(
      string,
      ~r/\b ( (?: [Xx]{1,3} | [Xx][Ll]   | [Ll][Xx]{0,3} )? (?: [Ii]{1,3} | [Ii][VvXx] | [Vv][Ii]{0,3} )? ) \b /x,
      fn numeral -> String.upcase(numeral) end
    )
  end

  defp replace_irish(string) do
    replace(string, ~r|\b(Mc)([A-Za-z]+)|, fn _, mc_prefix, rest_of_word ->
      mc_prefix <> String.capitalize(rest_of_word)
    end)
    |> replace(
      ~r|\b(Ma?c)([A-Za-z]{2,}[^aciozj])\b|,
      fn _, mc_prefix, rest_of_word ->
        mc_prefix <> String.capitalize(rest_of_word)
      end
    )
    |> replace(~r/\bMacEdo/, "Macedo")
    |> replace(~r/\bMacEvicius/, "Macevicius")
    |> replace(~r/\bMacHado/, "Machado")
    |> replace(~r/\bMacHar/, "Machar")
    |> replace(~r/\bMacHin/, "Machin")
    |> replace(~r/\bMacHlin/, "Machlin")
    |> replace(~r/\bMacIas/, "Macias")
    |> replace(~r/\bMacIulis/, "Maciulis")
    |> replace(~r/\bMacKie/, "Mackie")
    |> replace(~r/\bMacKle/, "Mackle")
    |> replace(~r/\bMacKlin/, "Macklin")
    |> replace(~r/\bMacKmin/, "Mackmin")
    |> replace(~r/\bMacQuarie/, "Macquarie")
    |> replace(~r/\bMacmurdo/, "MacMurdo")
  end
end
