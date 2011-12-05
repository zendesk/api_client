require "rubygems"
require "bundler/setup"
$:.push File.expand_path("../../lib", __FILE__)
require "rspec"

require 'simplecov'
SimpleCov.start do
  add_filter '/spec'
end

require "api_client"

Dir.glob("#{File.dirname(__FILE__)}/support/*.rb").each { |f| require f }
