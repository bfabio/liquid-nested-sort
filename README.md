# liquid-nested-sort

[![Gem Version](https://img.shields.io/gem/v/liquid-nested-sort.svg)](https://rubygems.org/gems/liquid-nested-sort)

`sort` and `sort_natural` filters with nested fields support for Liquid

## Installation

In the Gemfile

```ruby
gem 'liquid-nested-sort'
```

## Usage

```liquid
{{ places | nested_sort "address.street" }}
```

```liquid
{{ places | nested_sort_natural "address.street" }}
```
