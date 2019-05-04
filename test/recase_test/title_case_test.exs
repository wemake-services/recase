defmodule Recase.TitleCaseTest do
  use ExUnit.Case

  import Recase.TitleCase

  doctest Recase.TitleCase

  test "should title case usual text" do
    assert convert("title case") == "Title Case"
    assert convert("titleCase") == "Title Case"
    assert convert("title_Case") == "Title Case"
    assert convert("titleCase") == "Title Case"
    assert convert("title.Case") == "Title Case"
    assert convert("title case") == "Title Case"
    assert convert("--title-case--") == "Title Case"
    assert convert("title#case") == "Title Case"
    assert convert("title?!case") == "Title Case"
  end

  test "should return single letter" do
    assert convert("a") == "A"
  end

  test "should return phrases with more than 2 words" do
    assert convert("ThreeSeparateWords") == "Three Separate Words"
    assert convert("MoreThanThreeWords") == "More Than Three Words"
  end

  test "should return empty string" do
    assert convert("") == ""
  end
end
