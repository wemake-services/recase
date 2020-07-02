defmodule RecaseReplaceTest do
  use ExUnit.Case

  test "replace has the same behavior of Regex.replace with different argument ordering" do
    assert Recase.Replace.replace("foo", ~r|oo|, "aa") ==
             Regex.replace(~r|oo|, "foo", "aa")
  end
end
