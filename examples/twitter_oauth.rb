require "rubygems"
require "bundler/setup"
require "./examples/config" if File.exist?('examples/config.rb')
require "api_client"

module TwitterOauth

  class Base < ApiClient::Base

    always do
      endpoint "https://api.twitter.com/"
      adapter  :oauth

      options  :oauth => {
        :consumer_key => TWITTER_CONSUMER_KEY, :consumer_secret => TWITTER_CONSUMER_SECRET
      }

    end

  end

  class Tweet < Base

    def self.tweet(message)
      build post('/1/statuses/update.json', :status => message)
    end

  end

end

config = { :token => TWITTER_TOKEN, :token_secret => TWITTER_SECRET }

message = TwitterOauth::Tweet.options(:oauth => config).tweet("test #{Time.now.to_i}")

puts message.text
