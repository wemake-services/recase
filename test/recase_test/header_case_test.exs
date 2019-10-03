defmodule Recase.HeaderCaseTest do
  use ExUnit.Case

  import Recase.HeaderCase

  doctest Recase.HeaderCase

  test "should header case usual text" do
    assert convert("header case") == "Header-Case"
    assert convert("headerCase") == "Header-Case"
    assert convert("Header_Case") == "Header-Case"
    assert convert("HeaderCase") == "Header-Case"
    assert convert("Header.Case") == "Header-Case"
    assert convert("Header-Case") == "Header-Case"
    assert convert("header-case") == "Header-Case"
    assert convert("--header-case--") == "Header-Case"
    assert convert("header#case") == "Header-Case"
    assert convert("header?!case") == "Header-Case"
  end

  test "should return single letter" do
    assert convert("a") == "A"
  end

  test "should return phrases with more than 2 words" do
    assert convert("ThreeSeparateWords") == "Three-Separate-Words"
    assert convert("MoreThanThreeWords") == "More-Than-Three-Words"
  end

  test "should return empty string" do
    assert convert("") == ""
  end
end
