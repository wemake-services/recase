defmodule Recase.NameCaseTest do
  use ExUnit.Case

  import Recase.NameCase

  doctest Recase.NameCase

  test "should name case usual text" do
    assert convert("keith") == "Keith"
    assert convert("leigh-williams") == "Leigh-Williams"
    assert convert("mccarthy") == "McCarthy"
    assert convert("o'callaghan") == "O'Callaghan"
    assert convert("st. john") == "St. John"
    assert convert("von streit") == "von Streit"
    assert convert("van dyke") == "van Dyke"
    assert convert("van") == "Van"
    assert convert("ap llwyd dafydd") == "ap Llwyd Dafydd"
    assert convert("al fahd") == "al Fahd"
    assert convert("al") == "Al"
    assert convert("el grecco") == "el Grecco"
    assert convert("bin friendly") == "bin Friendly"
    assert convert("ben gurion") == "ben Gurion"
    assert convert("ben") == "Ben"
    assert convert("dos brasileiros") == "dos Brasileiros"
    assert convert("da vinci") == "da Vinci"
    assert convert("di caprio") == "di Caprio"
    assert convert("du pont") == "du Pont"
    assert convert("de legate") == "de Legate"
    assert convert("del crond") == "del Crond"
    assert convert("der sind") == "der Sind"
    assert convert("van der Post") == "van der Post"
    assert convert("von trapp") == "von Trapp"
    assert convert("la poisson") == "la Poisson"
    assert convert("le figaro") == "le Figaro"
    assert convert("mack knife") == "Mack Knife"
    assert convert("dougal macdonald") == "Dougal MacDonald"
    assert convert("ruiz y picasso") == "Ruiz y Picasso"
    assert convert("dato e iradier") == "Dato e Iradier"
    assert convert("mas i gavarró") == "Mas i Gavarró"

    # Mac expectations
    assert convert("machin") == "Machin"
    assert convert("machlin") == "Machlin"
    assert convert("machar") == "Machar"
    assert convert("mackle") == "Mackle"
    assert convert("macklin") == "Macklin"
    assert convert("mackie") == "Mackie"
    assert convert("macquarie") == "Macquarie"
    assert convert("machado") == "Machado"
    assert convert("macevicius") == "Macevicius"
    assert convert("maciulis") == "Maciulis"
    assert convert("macias") == "Macias"
    assert convert("macmurdo") == "MacMurdo"

    # Roman Numerals
    assert convert("henry viii") == "Henry VIII"
    assert convert("louis iii") == "Louis III"
    assert convert("louis xiv") == "Louis XIV"
    assert convert("charles ii") == "Charles II"
    assert convert("fred xlix") == "Fred XLIX"
    assert convert("yusof bin ishak") == "Yusof bin Ishak"
  end

  test "should return single letter" do
    assert convert("a") == "A"
  end

  test "should return empty string" do
    assert convert("") == ""
  end
end
