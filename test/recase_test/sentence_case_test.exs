defmodule Recase.SentenceCaseTest do
  use ExUnit.Case

  import Recase.SentenceCase

  doctest Recase.SentenceCase

  test "should sentence case usual text" do
    assert convert("sentence case") == "Sentence case"
    assert convert("sentenceCase") == "Sentence case"
    assert convert("sentence_Case") == "Sentence case"
    assert convert("sentenceCase") == "Sentence case"
    assert convert("sentence.Case") == "Sentence case"
    assert convert("Sentence case") == "Sentence case"
    assert convert("--sentence-case--") == "Sentence case"
    assert convert("sentence#case") == "Sentence case"
    assert convert("sentence?!case") == "Sentence case"
  end

  test "should return single letter" do
    assert convert("a") == "A"
  end

  test "should return phrases with more than 2 words" do
    assert convert("ThreeSeparateWords") == "Three separate words"
    assert convert("MoreThanThreeWords") == "More than three words"
  end

  test "should return empty string" do
    assert convert("") == ""
  end
end
