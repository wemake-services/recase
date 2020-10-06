defmodule Recase.CamelCaseTest do
  use ExUnit.Case

  import Recase.CamelCase

  doctest Recase.CamelCase

  test "should camel case usual text" do
    assert convert("camel case") == "camelCase"
    assert convert("camel-case") == "camelCase"
    assert convert("camel.case") == "camelCase"
    assert convert("camel_case") == "camelCase"
    assert convert("CamelCase") == "camelCase"
    assert convert("camelCase") == "camelCase"
    assert convert("CAMelCase") == "camelCase"
    assert convert("camel-casE") == "camelCasE"
  end

  test "should not modify extra chars" do
    assert convert("!#$%^&*(){}[]~`'\"") == "$%^&*(){}[]~`'\""
  end

  test "should return single letter" do
    assert convert("a") == "a"
  end

  test "should return phrases with more than 2 words" do
    assert convert("ThreeSeparateWords") == "threeSeparateWords"
    assert convert("MoreThanThreeWords") == "moreThanThreeWords"
  end

  test "should return empty string" do
    assert convert("") == ""
  end

  test "should camel case atoms" do
    assert convert(:camel_case) == :camelCase
    assert convert(:CamelCase) == :camelCase
    assert convert(:camelCase) == :camelCase
    assert convert(:CAMelCase) == :camelCase
  end
end
