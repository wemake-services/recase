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
    assert convert("SNAKE_CASE") == "snake_case"
    assert convert("--snake-case--") == "snake_case"
    assert convert("snake#case") == "snake_case"
    assert convert("snake?!case") == "snake_case"
    assert convert("SnakeACase") == "snake_a_case"
    assert convert("CurrencyISOCode") == "currency_i_s_o_code"
  end

  test "should return single letter" do
    assert convert("a") == "a"
  end

  test "should return phrases with more than 2 words" do
    assert convert("ThreeSeparateWords") == "three_separate_words"
    assert convert("MoreThanThreeWords") == "more_than_three_words"
  end

  test "should return empty string" do
    assert convert("") == ""
  end

  test "should handle all upcase strings" do
    assert convert("CREATE_D") == "create_d"
    assert convert("CREATE_DT") == "create_dt"
    assert convert("CREATE_DATE") == "create_date"
  end

  test "should snake case atoms" do
    assert convert(:snakeCase) == :snake_case
    assert convert(:Snake_Case) == :snake_case
    assert convert(:SnakeCase) == :snake_case
    assert convert(:SNAKE_CASE) == :snake_case
  end
end
