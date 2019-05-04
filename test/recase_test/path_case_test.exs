defmodule Recase.PathCaseTest do
  use ExUnit.Case

  import Recase.PathCase

  doctest Recase.PathCase

  test "should path case usual text" do
    assert convert("path case") == "path/case"
    assert convert("pathCase") == "path/Case"
    assert convert("path_Case") == "path/Case"
    assert convert("PathCase") == "Path/Case"
    assert convert("path.CASE") == "path/CASE"
    assert convert("path-case") == "path/case"
  end

  test "should path case with different separator" do
    assert convert("path case", "\\") == "path\\case"
  end

  test "should preserve path chars" do
    assert convert("/path case") == "/path/case"
    assert convert("C:\\path case", "\\") == "C:\\path\\case"
  end

  test "should not modify extra chars" do
    assert convert("!#$%^&*(){}[]~`'\"") == "$%^&*(){}[]~`'\""
  end

  test "should return single letter" do
    assert convert("a") == "a"
  end

  test "should return phrases with more than 2 words" do
    assert convert("ThreeSeparateWords") == "Three/Separate/Words"
    assert convert("MoreThanThreeWords") == "More/Than/Three/Words"
  end

  test "should return empty string" do
    assert convert("") == ""
  end
end
