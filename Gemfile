source "http://rubygems.org"

# Specify your gem's dependencies in fs-api.gemspec
gemspec

# Testing
gem "simplecov"

# Soft dependencies
gem "simple_oauth", '0.2.0'
gem 'multi_xml'
gem "libxml-ruby"

# multi_json < 1.21 passes positional options to JSON.parse, which the
# json gem 3.x no longer accepts (ArgumentError at parse time). multi_json
# 1.21+ requires Ruby >= 3.2, so on older rubies keep json 2.x installed
# for multi_json to work with.
gem 'json', '< 3' if RUBY_VERSION < '3.2.0'
