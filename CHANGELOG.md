# Changelog

## Version 0.4.0

### Features

- Adds `sentence_case`, see [#38](https://github.com/sobolevn/recase/pull/38)
- Adds `title_case`, see [#38](https://github.com/sobolevn/recase/pull/39)

### Misc

- Package version updates


## Version 0.3.0

### Breaking changes

- `snake_case` now removes punctuation, see [#5](https://github.com/sobolevn/recase/issues/5)
- Minimal `elixir` version is now `1.5`


## Version 0.2.0

This version brings just one, but braking change. As it was discussed `to_upper` is a misleading name for a function. It is not clear what this function does. Since traditionally `uppercase` is just all uppercased letters. And it has nothing to do with `PascalCase`.

### Braking changes

- `UpperCase` renamed to `PascalCase` ([#2](https://github.com/sobolevn/recase/issues/2))
- `Recase.to_upper/1` renamed to `Recase.to_pascal/1` ([#2](https://github.com/sobolevn/recase/issues/2))

### Tests

- `upper_case_test.exs` renamed to `pascal_case_test.exs`

### Documentation

- Made changes to reflect `Pascal` and `Upper` case issue


## Version 0.1.1

### Improvements

- Adds `Path/case`, `dot.case`, and `CONTANT_CASE`
- Updates tests

### Documentation

- Updates documentation
- Updates README


## Version 0.1.0

Initial release supporting: `UpperCase`, `camelCase`, `snake_case`, `kebab-case`.
