defmodule Recase.KebabCaseTest do
  use ExUnit.Case

  import Recase.KebabCase

  doctest Recase.KebabCase

  test "should kebab case usual text" do
    assert convert("kebab case") == "kebab-case"
    assert convert("kebabCase") == "kebab-case"
    assert convert("Kebab_Case") == "kebab-case"
    assert convert("KebabCase") == "kebab-case"
    assert convert("Kebab.Case") == "kebab-case"
    assert convert("kebab-case") == "kebab-case"
    assert convert("--kebab-case--") == "kebab-case"
    assert convert("kebab#case") == "kebab-case"
    assert convert("kebab?!case") == "kebab-case"
  end

  test "should return single letter" do
    assert convert("a") == "a"
  end

  test "should return phrases with more than 2 words" do
    assert convert("ThreeSeparateWords") == "three-separate-words"
    assert convert("MoreThanThreeWords") == "more-than-three-words"
  end

  test "should return empty string" do
    assert convert("") == ""
  end
end
