# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "api_client/version"

Gem::Specification.new do |s|
  s.name        = "api_client"
  s.version     = ApiClient::VERSION
  s.authors     = ["Marcin Bunsch"]
  s.email       = ["marcin@futuresimple.com"]
  s.homepage    = "https://github.com/futuresimple/api_client"
  s.summary     = %q{API client builder}
  s.description = %q{API client builder}

  s.rubyforge_project = "api_client"

  def use(s, method, *args)
    s.send method, *args
  end

  # Declare runtime dependencies here:
  def add_runtime_dependencies(s, method)
    if RUBY_PLATFORM == "java"
      use(s, method, 'json_pure')
    else
      use(s, method, 'yajl-ruby')
    end

    use(s, method, 'faraday', [">= 0.8.1"])
    use(s, method, 'hashie', [">= 2.0.5"])
    use(s, method, 'multi_json', [">= 1.6.1"])
  end

  # Declare development dependencies here:
  s.add_development_dependency 'rspec', '2.14.1'

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      add_runtime_dependencies(s, :add_runtime_dependency)
    else
      add_runtime_dependencies(s, :add_dependency)
    end
  else
    add_runtime_dependencies(s, :add_dependency)
  end

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
