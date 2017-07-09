defmodule Recase.SnakeCaseTest do
  use ExUnit.Case

  import Recase.SnakeCase

  doctest Recase.SnakeCase

  test "should snake case usual text" do
    assert convert("snake case") == "snake_case"
    assert convert("snakeCase") == "snake_case"
    assert convert("Snake-Case") == "snake_case"
    assert convert("Snake_Case") == "snake_case"
    assert convert("SnakeCase") == "snake_case"
    assert convert("Snake.Case") == "snake_case"
  end

  test "should not modify extra chars" do
    assert convert("!#$%^&*(){}[]~`'\"") == "!#$%^&*(){}[]~`'\""
  end

  test "should return single letter" do
    assert convert("a") == "a"
  end

  test "should return empty string" do
    assert convert("") == ""
  end
end
