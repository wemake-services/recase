defmodule Recase.DotCaseTest do
  use ExUnit.Case

  import Recase.DotCase

  doctest Recase.DotCase

  test "should dot case usual text" do
    expected = "dot.case"
    assert convert("dot case") == expected
    assert convert("dotCase") == expected
    assert convert("dot_Case") == expected
    assert convert("dotCase") == expected
    assert convert("dot.Case") == expected
    assert convert("dot-case") == expected
    assert convert("--dot-case--") == expected
    assert convert("dot#case") == expected
    assert convert("dot?!case") == expected
  end

  test "should return single letter" do
    assert convert("a") == "a"
  end

  test "should return empty string" do
    assert convert("") == ""
  end
end
