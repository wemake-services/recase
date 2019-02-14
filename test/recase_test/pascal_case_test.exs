defmodule Recase.PascalCaseTest do
  use ExUnit.Case

  import Recase.PascalCase

  doctest Recase.PascalCase

  test "should pascal case usual text" do
    assert convert("upper case") == "UpperCase"
    assert convert("upper-case") == "UpperCase"
    assert convert("upper.case") == "UpperCase"
    assert convert("upper_case") == "UpperCase"
    assert convert("upperCase") == "UpperCase"
    assert convert("UpperCase") == "UpperCase"
  end

  test "should not modify extra chars" do
    assert convert("!#$%^&*(){}[]~`'\"") == "$%^&*(){}[]~`'\""
  end

  test "should return single letter" do
    assert convert("a") == "A"
  end

  test "should return empty string" do
    assert convert("") == ""
  end
end
