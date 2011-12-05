require "rubygems"
require "bundler/setup"
require "api_client"

module Digg

  class Base < ApiClient::Base

    always do
      endpoint "http://services.digg.com"
      params   :type => 'json'
    end

  end

  class Collection < Base

    def self.diggs
      Digg.build get('/2.0/digg.getAll')['diggs']
    end

  end

  class Digg < Base
  end

end

Digg::Collection.diggs.each do |digg|
  puts "#{digg.user.name}: #{digg.item.title}"
end
