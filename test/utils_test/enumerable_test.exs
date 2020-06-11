defmodule RecaseEnumerableTest do
  use ExUnit.Case

  describe "convet_keys/2" do
    test "should convert keys of a map" do
      assert Recase.Enumerable.convert_keys(
               %{"upper case" => "value", "upper-case2" => "value"},
               &Recase.to_pascal/1
             ) == %{"UpperCase" => "value", "UpperCase2" => "value"}
    end

    test "should convert keys of a nested map" do
      assert Recase.Enumerable.convert_keys(
               %{"upper case" => %{"upper-case2" => "value"}},
               &Recase.to_path(&1, "\\")
             ) == %{"upper\\case" => %{"upper\\case2" => "value"}}
    end

    test "should convert keys of a map in list" do
      assert Recase.Enumerable.convert_keys(
               [%{"upper case" => "value", "upper-case2" => "value"}],
               &Recase.to_pascal/1
             ) == [%{"UpperCase" => "value", "UpperCase2" => "value"}]
    end

    test "should convert keys of a nested map in list" do
      assert Recase.Enumerable.convert_keys(
               [%{"upper case" => %{"upper-case2" => "value"}}],
               &Recase.to_pascal/1
             ) == [%{"UpperCase" => %{"UpperCase2" => "value"}}]
    end

    test "should return the same list when list items are usual text" do
      assert Recase.Enumerable.convert_keys(
               ["upper case", "upper-case2"],
               &Recase.to_pascal/1
             ) == ["upper case", "upper-case2"]
    end
  end

  describe "atomize_keys/2" do
    test "should convert keys of a map" do
      assert Recase.Enumerable.atomize_keys(
               %{"upper case" => "value", "upper-case2" => "value"},
               &Recase.to_pascal/1
             ) == %{UpperCase: "value", UpperCase2: "value"}
    end

    test "should convert keys of a nested map" do
      assert Recase.Enumerable.atomize_keys(
               %{"upper case" => %{"upper-case2" => "value"}},
               &Recase.to_path(&1, "\\")
             ) == %{:"upper\\case" => %{:"upper\\case2" => "value"}}
    end

    test "should convert keys of a map in list" do
      assert Recase.Enumerable.atomize_keys(
               [%{"upper case" => "value", "upper-case2" => "value"}],
               &Recase.to_pascal/1
             ) == [%{UpperCase: "value", UpperCase2: "value"}]
    end

    test "should convert keys of a nested map in list" do
      assert Recase.Enumerable.atomize_keys(
               [%{"upper case" => %{"upper-case2" => "value"}}],
               &Recase.to_pascal/1
             ) == [%{UpperCase: %{UpperCase2: "value"}}]
    end

    test "should return the same list when list items are usual text" do
      assert Recase.Enumerable.convert_keys(
               ["upper case", "upper-case2"],
               &Recase.to_pascal/1
             ) == ["upper case", "upper-case2"]
    end
  end
end
