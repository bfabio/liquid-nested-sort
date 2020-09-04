# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name = 'liquid-nested-sort'
  s.version = '0.1.0'
  s.date = '2020-09-03'

  s.author = 'Fabio Bonelli'
  s.email = 'fb@fabiobonelli.it'
  s.license = 'BSD-3-Clause'
  s.homepage = 'https://github.com/bfabio/liquid-nested-sort'

  s.summary = 'sort and sort_natural filters with nested fields support for Liquid'
  s.description =
    "Liquid's sort and sort_natural don't support nested fields out of the box." \
    'This gems provides nested_sort and nester_sort_natural.'

  s.files = ['lib/liquid_nested_sort.rb']

  s.add_runtime_dependency('liquid', ['>= 4.0', '< 5.0'])
  s.required_ruby_version = '~> 2.4'
end
