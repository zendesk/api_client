# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "api_client/version"

Gem::Specification.new do |s|
  s.name        = "api_client"
  s.version     = ApiClient::VERSION
  s.authors     = ["Marcin Bunsch"]
  s.email       = ["marcin@futuresimple.com"]
  s.homepage    = ""
  s.summary     = %q{API client builder}
  s.description = %q{API client builder}

  s.rubyforge_project = "api_client"

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      if RUBY_PLATFORM == "java"
	      s.add_runtime_dependency(%q<json_pure>) 
      else 
	      s.add_runtime_dependency(%q<yajl-ruby>) 
      end
      s.add_runtime_dependency(%q<faraday>, [">= 0.8.1"])
      s.add_runtime_dependency(%q<hashie>, [">= 1.2.0"])
      s.add_runtime_dependency(%q<multi_json>, [">= 1.6.1"])
    else
      if RUBY_PLATFORM == "java"
	      s.add_dependency(%q<json_pure>) 
      else 
	      s.add_dependency(%q<yajl-ruby>) 
      end
      s.add_dependency(%q<faraday>, [">= 0.8.1"])
      s.add_dependency(%q<hashie>, [">= 1.2.0"])
      s.add_dependency(%q<multi_json>, [">= 1.6.1"])
    end
  else
    if RUBY_PLATFORM == "java"
      s.add_dependency(%q<json_pure>) 
    else 
      s.add_dependency(%q<yajl-ruby>) 
    end
    s.add_dependency(%q<faraday>, [">= 0.8.1"])
    s.add_dependency(%q<hashie>, [">= 1.2.0"])
    s.add_dependency(%q<multi_json>, [">= 1.6.1"])
  end

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
