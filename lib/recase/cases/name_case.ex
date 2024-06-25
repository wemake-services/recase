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
    |> replace(~r|\b\w|u, fn first_char_of_word ->
      String.upcase(first_char_of_word)
    end)
    |> replace(~r|\'\w\b|u, fn apostophe_ess ->
      String.downcase(apostophe_ess)
    end)
    |> replace_irish()
    |> replace(~r|\bVon(?=\s+\w)|u, "von")
    |> replace(~r|\bVan(?=\s+\w)|u, "van")
    |> replace(~r|\bAp(?=\s+\w)|u, "ap")
    |> replace(~r|\bAl(?=\s+\w)|u, "al")
    |> replace(~r|\bEl(?=\s+\w)|u, "el")
    |> replace(~r|\bLa(?=\s+\w)|u, "la")
    |> replace(~r|\bBen(?=\s+\w)|u, "ben")
    |> replace(~r/\b(Bin|Binti|Binte)(?=\s+\w)/u, fn bin_prefix ->
      String.downcase(bin_prefix)
    end)
    |> replace(~r|\bD([aeiou])(?=\s+\w)|u, fn da_prefix ->
      String.downcase(da_prefix)
    end)
    |> replace(~r|\bD([ao]s)(?=\s+\w)|u, fn das_prefix ->
      String.downcase(das_prefix)
    end)
    |> replace(~r|\bDell([ae])(?=\s+\w)|u, fn dell_prefix ->
      String.downcase(dell_prefix)
    end)
    |> replace(~r|\bDe([lr])(?=\s+\w)|u, fn del_prefix ->
      String.downcase(del_prefix)
    end)
    |> replace(~r|\bL([eo])(?=\s+\w)|u, fn le_prefix ->
      String.downcase(le_prefix)
    end)
    |> replace_roman_numerals()
    |> replace(~r|\b([YEI])\b|u, fn conjunction ->
      String.downcase(conjunction)
    end)
  end

  defp replace_roman_numerals(string) do
    replace(
      string,
      ~r/\b ( (?: [Xx]{1,3} | [Xx][Ll]   | [Ll][Xx]{0,3} )? (?: [Ii]{1,3} | [Ii][VvXx] | [Vv][Ii]{0,3} )? ) \b /xu,
      fn numeral -> String.upcase(numeral) end
    )
  end

  defp replace_irish(string) do
    replace(string, ~r|\b(Mc)([A-Za-z]+)|u, fn _, mc_prefix, rest_of_word ->
      mc_prefix <> String.capitalize(rest_of_word)
    end)
    |> replace(
      ~r|\b(Ma?c)([A-Za-z]{2,}[^aciozj])\b|u,
      fn _, mc_prefix, rest_of_word ->
        mc_prefix <> String.capitalize(rest_of_word)
      end
    )
    |> replace(~r/\bMacEdo/u, "Macedo")
    |> replace(~r/\bMacEvicius/u, "Macevicius")
    |> replace(~r/\bMacHado/u, "Machado")
    |> replace(~r/\bMacHar/u, "Machar")
    |> replace(~r/\bMacHin/u, "Machin")
    |> replace(~r/\bMacHlin/u, "Machlin")
    |> replace(~r/\bMacIas/u, "Macias")
    |> replace(~r/\bMacIulis/u, "Maciulis")
    |> replace(~r/\bMacKie/u, "Mackie")
    |> replace(~r/\bMacKle/u, "Mackle")
    |> replace(~r/\bMacKlin/u, "Macklin")
    |> replace(~r/\bMacKmin/u, "Mackmin")
    |> replace(~r/\bMacQuarie/u, "Macquarie")
    |> replace(~r/\bMacmurdo/u, "MacMurdo")
  end
end
