# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "api_client/version"

Gem::Specification.new do |s|
  s.name        = "api_client"
  s.version     = ApiClient::VERSION
  s.authors     = ["Zendesk"]
  s.email       = ["opensource@zendesk.com"]
  s.homepage    = "https://github.com/futuresimple/api_client"
  s.summary     = %q{API client builder}
  s.description = %q{API client builder}
  s.license     = "Apache License Version 2.0"

  s.rubyforge_project = "api_client"
  s.required_ruby_version = ">= 2.2.0"

  s.platform = "java" if RUBY_PLATFORM == "java"

  # Declare runtime dependencies here:
  def s.add_runtime_dependencies(method)
    if RUBY_PLATFORM == "java"
      send method, 'jrjackson'
    else
      send method, 'yajl-ruby'
    end

    send method, 'hashie', [">= 2.0.5"]
    send method, 'faraday', [">= 0.8.1", "< 2.0.0"]
    send method, 'multi_json', [">= 1.6.1"]
  end

  # Declare development dependencies here:
  s.add_development_dependency 'rspec', '2.14.1'

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependencies(:add_runtime_dependency)
    else
      s.add_runtime_dependencies(:add_dependency)
    end
  else
    s.add_runtime_dependencies(:add_dependency)
  end

  s.files         = Dir['lib/**/*.rb'] + Dir['spec/**/*.rb'] + Dir['[A-Z]*']
  s.test_files    = Dir['spec/**/*.rb']
  s.executables   = []
  s.require_paths = ["lib"]
end
