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
end
