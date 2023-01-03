require "rubygems"
require "bundler/setup"
require "./examples/config" if File.exist?('examples/config.rb')
require "api_client"

module Flickr

  class Base < ApiClient::Base
    always do
      endpoint "http://api.flickr.com"
      params   :api_key => FLICKR_API_KEY,
               :format => 'json',
               :nojsoncallback => 1
    end
  end

  class Collection < Base

    def self.interesting
      build params(:method => 'flickr.interestingness.getList').
            get("/services/rest")
    end

    def photos
      Photo.build self['photos']['photo']
    end

  end

  class Photo < Base
  end

end

Flickr::Collection.interesting.photos.each do |photo|
  puts photo.title
end
