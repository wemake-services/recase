defmodule RecaseTest do
  use ExUnit.Case
  doctest Recase

  test "should convert to camelCase" do
    assert Recase.to_camel("some value") == "someValue"
    assert Recase.to_camel(:some_value) == :someValue
  end

  test "should convert to snake_case" do
    assert Recase.to_snake("some value") == "some_value"
    assert Recase.to_snake(:someValue) == :some_value
  end

  test "should convert to kebab-case" do
    assert Recase.to_kebab("some value") == "some-value"
  end

  test "should convert to PascalCase" do
    assert Recase.to_pascal("some value") == "SomeValue"
    assert Recase.to_pascal(:someValue) == :SomeValue
  end

  test "should convert to CONSTANT_CASE" do
    assert Recase.to_constant("some value") == "SOME_VALUE"
    assert Recase.to_constant(:someValue) == :SOME_VALUE
  end

  test "should convert to Path/Case" do
    assert Recase.to_path("some value") == "some/value"
    assert Recase.to_path("Some Value", "\\") == "Some\\Value"
  end

  test "should convert to dot.case" do
    assert Recase.to_dot("Some Value") == "some.value"
  end

  test "should convert to Sentence case" do
    assert Recase.to_sentence("Some Value") == "Some value"
  end

  test "should convert to Title Case" do
    assert Recase.to_title("Some Value") == "Some Value"
  end
end
