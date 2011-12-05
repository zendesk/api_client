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

  s.add_dependency 'faraday', "=0.7.5"
  s.add_dependency 'hashie',  "=1.2.0"
  s.add_dependency 'yajl-ruby'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
