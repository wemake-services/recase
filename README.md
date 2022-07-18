# Recase

![Recase](https://raw.githubusercontent.com/wemake-services/recase/master/media/logo.png)

[![Build Status](https://github.com/wemake-services/recase/workflows/test/badge.svg?branch=master&event=push)](https://github.com/wemake-services/recase/actions?query=workflow%3Atest)
[![Coverage Status](https://coveralls.io/repos/github/wemake-services/recase/badge.svg?branch=master)](https://coveralls.io/github/wemake-services/recase?branch=master)
[![Hex Version](https://img.shields.io/hexpm/v/recase.svg)](https://hex.pm/packages/recase)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/recase/)
[![Total Download](https://img.shields.io/hexpm/dt/recase.svg)](https://hex.pm/packages/recase)
[![License](https://img.shields.io/hexpm/l/recase.svg)](https://github.com/wemake-services/recase/blob/master/LICENSE.md)
[![Last Updated](https://img.shields.io/github/last-commit/wemake-services/recase.svg)](https://github.com/wemake-services/recase/commits/master)

`Recase` helps you to convert a string from any case to any case.

## Why?

One can ask: "Why should I use `Recase` when I can use built-in `Macro` module?". But, you have to keep in mind that `Macro`'s functions are [not suitable](https://github.com/elixir-lang/elixir/blob/4aa81645b0588b56fb61cd154dcaee354732aa5c/lib/elixir/lib/macro.ex#L1265) for general case usage:

> Do not use it as a general mechanism for underscoring or camelizing strings as it does not support Unicode or characters that are not valid in Elixir identifiers.

## Installation

```elixir
def deps do
  [
    {:recase, "~> 0.5"}
  ]
end
```

## Usage

### Pascal

Pascal (or Upper) case uses mixed case with lower and upper cased characters. Separates words from each other with the upper case letters. Starts with upper case letter.

```elixir
Recase.to_pascal("some-value") # => "SomeValue"
Recase.to_pascal("Some value") # => "SomeValue"
```

### Camel

Camel case uses mixed case with lower and upper cased characters. Separates words from each other with the upper cased letters. Starts with lower case letter.

```elixir
Recase.to_camel("some-value") # => "someValue"
Recase.to_camel("Some Value") # => "someValue"
```

### Snake

Snake cases uses all lower case. Uses `_` as a separator.

```elixir
Recase.to_snake("someValue") # => "some_value"
Recase.to_snake("Some Value") # => "some_value"
```

### Kebab

Kebab cases uses all lower case. Uses `-` as a separator.

```elixir
Recase.to_kebab("someValue") # => "some-value"
Recase.to_kebab("Some Value") # => "some-value"
```

### Constant

Constant case uses all upper case. Uses `_` as a separator.

```elixir
Recase.to_constant("SomeValue") # => "SOME_VALUE"
Recase.to_constant("some value") # => "SOME_VALUE"
```

### Dot

Dot case uses all lower case similar to snake case. Uses `.` as a separator.

```elixir
Recase.to_dot("SomeValue") # => "some.value"
Recase.to_dot("some value") # => "some.value"
```

### Path

Path case preserves case, you can also provide a separator as the second argument.

```elixir
Recase.to_path("SomeValue") # => "Some/Value"
Recase.to_path("some value", "\\") # => "some\\value"
```

### Sentence

Sentence case uses the same rules as regular sentence.
First letter is uppercase all others letters are lowercase separated by spaces.

```elixir
Recase.to_sentence("SomeValue") # => "Some value"
Recase.to_sentence("some value") # => "Some value"
```

### Title

Title case applies a "Title Style" to all words in a sentence.

```elixir
Recase.to_title("some-value") # => "Some Value"
Recase.to_title("some value") # => "Some Value"
```

### Header

Header case uses the same case as PascalCase, while using `-` as a separator.

```elixir
Recase.to_header("SomeValue") # => "Some-Value"
Recase.to_header("some value") # => "Some-Value"
```

### Enumerable

You can convert all keys in an enumerable with:

```elixir
Recase.Enumerable.convert_keys(
  %{"yourKey" => "value"},
  &Recase.to_snake/1
) # => %{"your_key" => "value"}

Recase.Enumerable.convert_keys(
  %{"your_key" => "value"},
  &Recase.to_camel/1
) # => %{"yourKey" => "value"}

Recase.Enumerable.atomize_keys(
  %{"yourKey" => "value"},
  &Recase.to_snake/1
) # => %{your_key: "value"}

Recase.Enumerable.atomize_keys(
  %{"your_key" => "value"},
  &Recase.to_camel/1
) # => %{yourKey: "value"}
```

## Changelog

Full changelog is available [here](./CHANGELOG.md).

## Copyright and License

Copyright (c) 2017 Nikita Sobolev

This work is free. You can redistribute it and/or modify it under the
terms of the MIT License. See the [LICENSE.md](./LICENSE.md) file for more details.

## Thanks

Thanks to [Gyan Lakhwani](https://github.com/gyanl) for the logo.
