defmodule Recase.ConstantCaseTest do
  use ExUnit.Case

  import Recase.ConstantCase

  doctest Recase.ConstantCase

  test "should constant case usual text" do
    expected = "CONSTANT_CASE"
    assert convert("constant case") == expected
    assert convert("constantCase") == expected
    assert convert("constant-Case") == expected
    assert convert("constant_Case") == expected
    assert convert("constant.Case") == expected
    assert convert("ConstantCase") == expected
  end

  test "should not modify extra chars" do
    assert convert("!#$%^&*(){}[]~`'\"") == "!#$%^&*(){}[]~`'\""
  end

  test "should return single letter" do
    assert convert("a") == "A"
  end

  test "should return empty string" do
    assert convert("") == ""
  end
end
