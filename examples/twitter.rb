require "rubygems"
require "bundler/setup"
require "api_client"

module Twitter

  class Base < ApiClient::Base
    always do
      endpoint    "http://api.twitter.com/"
    end
  end

  class Tweet < Base
  end

  class User < Base

    def self.find_by_username(name)
      params(:screen_name => name).fetch("/1/users/show.json")
    end

    def tweets
      Tweet.params(:screen_name => self.screen_name).fetch("/1/statuses/user_timeline.json")
    end

  end

end

user = Twitter::User.find_by_username("marcinbunsch")
puts user.name
user.tweets.each do |tweet|
  puts "  #{tweet.text}"
end
