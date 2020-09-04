# liquid-nested-sort

[![Gem Version](https://img.shields.io/gem/v/liquid-nested-sort.svg)](https://rubygems.org/gems/liquid-nested-sort)

`nested_sort` and `nested_sort_natural`, sort and sort_natural-like filters
with nested fields support for [Liquid](https://shopify.github.io/liquid/).

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

## Thanks

This is mostly based on @untra's work (https://github.com/untra).
