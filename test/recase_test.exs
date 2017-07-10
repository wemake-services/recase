defmodule RecaseTest do
  use ExUnit.Case
  doctest Recase

  test "should convert to camelCase" do
    assert Recase.to_camel("some value") == "someValue"
  end

  test "should convert to snake_case" do
    assert Recase.to_snake("some value") == "some_value"
  end

  test "should convert to kebab-case" do
    assert Recase.to_kebab("some value") == "some-value"
  end

  test "should convert to UpperCase" do
    assert Recase.to_upper("some value") == "SomeValue"
  end

  test "should convert to CONSTANT_CASE" do
    assert Recase.to_constant("some value") == "SOME_VALUE"
  end

  test "should convert to Path/Case" do
    assert Recase.to_path("some value") == "some/value"
    assert Recase.to_path("Some Value", "\\") == "Some\\Value"
  end

  test "should convert to dot.case" do
    assert Recase.to_dot("Some Value") == "some.value"
  end
end
