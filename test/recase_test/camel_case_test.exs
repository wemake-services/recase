defmodule Recase.CamelCaseTest do
  use ExUnit.Case

  alias Recase.CamelCase

  doctest CamelCase

  test "should camel case usual text" do
    assert CamelCase.convert("camel case") == "camelCase"
    assert CamelCase.convert("camel-case") == "camelCase"
  end

  test "should return empty string" do
    assert CamelCase.convert("") == ""
  end
end
