# Recase

[![Build Status](https://travis-ci.org/sobolevn/recase.svg?branch=master)](https://travis-ci.org/sobolevn/recase) [![Coverage Status](https://coveralls.io/repos/github/sobolevn/recase/badge.svg?branch=master)](https://coveralls.io/github/sobolevn/recase?branch=master) [![Hex Version](https://img.shields.io/hexpm/v/recase.svg)](https://hex.pm/packages/recase) [![License](http://img.shields.io/badge/license-MIT-brightgreen.svg)](http://opensource.org/licenses/MIT)

`Recase` helps you to convert a string from any case to any case.


## Installation

```elixir
def deps do
  [{:recase, "~> 0.1"}]
end
```


## Usage

### Upper

```elixir
Recase.to_upper("some-value")
# => "SomeValue"

Recase.to_upper("Some value")
# => "SomeValue"
```

### Camel

```elixir
Recase.to_camel("some-value")
# => "someValue"

Recase.to_camel("Some Value")
# => "someValue"
```

### Snake

```elixir
Recase.to_snake("someValue")
# => "some_value"

Recase.to_snake("Some Value")
# => "some_value"
```

### Kebab

```elixir
Recase.to_kebab("someValue")
# => "some-value"

Recase.to_kebab("Some Value")
# => "some-value"
```


## License

MIT. See [LICENSE.md](/LICENSE.md) for more details.
