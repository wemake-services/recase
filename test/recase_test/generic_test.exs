defmodule Recase.GenericTest do
  use ExUnit.Case

  import Recase.Generic

  doctest Recase.Generic

  describe "safe_atom/1" do
    test "known atom" do
      known_atom = :test
      assert known_atom == safe_atom(Atom.to_string(known_atom))
    end

    test "unknown atom" do
      assert :random_string_that_has_no_existing_atom ==
               safe_atom("random_string_that_has_no_existing_atom")
    end
  end
end
