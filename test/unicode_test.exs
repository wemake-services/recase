defmodule UnicodeTest do
  use ExUnit.Case

  require Recase.Guards

  test "assert is_lowercase/1" do
    "olá"
    |> String.normalize(:nfc)
    |> String.codepoints()
    |> Enum.each(&assert(Recase.Guards.is_lowercase(&1)))
  end

  test "refute is_lowercase/1" do
    "OLÁ1= "
    |> String.normalize(:nfc)
    |> String.codepoints()
    |> Enum.each(&refute(Recase.Guards.is_lowercase(&1)))
  end

  test "assert is_uppercase/1" do
    "OLÁ"
    |> String.normalize(:nfc)
    |> String.codepoints()
    |> Enum.each(&assert(Recase.Guards.is_uppercase(&1)))
  end

  test "refute is_uppercase/1" do
    "olá1= "
    |> String.normalize(:nfc)
    |> String.codepoints()
    |> Enum.each(&refute(Recase.Guards.is_uppercase(&1)))
  end

  test "casing/1" do
    assert ("oóOÓ1= "
    |> String.normalize(:nfc)
    |> String.codepoints()
    |> Enum.map(&Recase.Guards.casing/1)) == [
      :lower, :lower, :upper, :upper, :not_a_letter, :not_a_letter, :not_a_letter
    ]
  end
end
