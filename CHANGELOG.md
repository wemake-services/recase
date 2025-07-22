# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).


## Version 0.9.0 (2025-07-22)

### Features

- Supports latest Elixir versions

### Bugfixes

- Avoids storing regexs on module level, #216

### Misc

- Updates multiple deps


## Version 0.8.1 (2024-06-25)

### Bugfixes

- Fixes how names like `von` are uppercased


## Version 0.8.0 (2024-05-28)

### Features

- Now supports elixir `1.14+`

### Bugfixes

- Fixes a bug with `NameCase` and unicode chars #176
- Uses `Application.compile_env`


## Version 0.7.0 (2020-10-06)

### Features

- Adds ability to convert with `:atom`

### Fixes

- Fixes how we handle several types of values in `Recase.Enumerable`


## Version 0.6.0 (2019-07-10)

### Features

- Adds `Recase.Enumerable`


## Version 0.5.0 (2019-07-01)

### Features

- Improves performance, see [#46](https://github.com/wemake-services/recase/pull/46)
- Adds `title_case`, see [#38](https://github.com/wemake-services/recase/pull/39)

### Misc

- Bumped minimal `elixir` version to `1.6` due to `mix format`
- Package version updates
- New elixir versions support in travis
- Adds `elixir1.9` support
- Adds `mix format`


## Version 0.4.0 (2018-12-25)

### Features

- Adds `sentence_case`, see [#38](https://github.com/wemake-services/recase/pull/38)

### Misc

- Package version updates


## Version 0.3.0 (2018-01-18)

### Breaking changes

- `snake_case` now removes punctuation, see [#5](https://github.com/wemake-services/recase/issues/5)
- Minimal `elixir` version is now `1.5`


## Version 0.2.0 (2017-07-15)

This version brings just one, but braking change. As it was discussed `to_upper` is a misleading name for a function. It is not clear what this function does. Since traditionally `uppercase` is just all uppercased letters. And it has nothing to do with `PascalCase`.

### Braking changes

- `UpperCase` renamed to `PascalCase` ([#2](https://github.com/wemake-services/recase/issues/2))
- `Recase.to_upper/1` renamed to `Recase.to_pascal/1` ([#2](https://github.com/wemake-services/recase/issues/2))

### Tests

- `upper_case_test.exs` renamed to `pascal_case_test.exs`

### Documentation

- Made changes to reflect `Pascal` and `Upper` case issue


## Version 0.1.1 (2017-07-12)

### Improvements

- Adds `Path/case`, `dot.case`, and `CONTANT_CASE`
- Updates tests

### Documentation

- Updates documentation
- Updates README


## Version 0.1.0 (2017-07-08)

Initial release supporting: `UpperCase`, `camelCase`, `snake_case`, `kebab-case`.
