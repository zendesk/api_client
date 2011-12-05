require "rubygems"
require "bundler/setup"
require "./examples/config" if File.exists?('examples/config.rb')
require "api_client"
require "multi_xml"

module Highrise

  class Base < ApiClient::Resource::Base
    format      :xml

    # In this hook we set the basic auth provided in the options
    connection do |connection|
      connection.handler.basic_auth connection.options[:user], connection.options[:pass]
    end

    always do
      endpoint HIGHRISE_URL
      options(:user => HIGHRISE_TOKEN, :pass => 'X')
    end

  end

  class Person < Base
    namespace false

    always do
      path "people"
    end

    def self.build_one(hash)
      hash.has_key?('people') ? build_many(hash['people']) : super(hash)
    end

  end

end

Highrise::Person.find_all.each do |person|
  puts "#{person.first_name} #{person.last_name}"
end
