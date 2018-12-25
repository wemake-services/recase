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

  test "should return empty string" do
    assert convert("") == ""
  end
end
