require "rubygems"
require "bundler/setup"
require "./examples/config" if File.exists?('examples/config.rb')
require "api_client"
require "time"

module Github

  class Base < ApiClient::Base
    namespace false

    always do
      endpoint "https://api.github.com"
    end
  end

  class User < Base

    def self.find(name)
      fetch("/users/#{name}")
    end

    def events
      Github::Event.fetch("/users/#{login}/events")
    end

    def received_events
      Github::Event.fetch("/users/#{login}/received_events")
    end

  end

  class Event < Base

    def created_at
      Time.parse self['created_at']
    end

  end

end

user = Github::User.find("marcinbunsch")

user.events.each do |event|
  case event.type
    when "FollowEvent"
      puts "#{event.created_at} #{event.payload.target.login}: #{event.type}"
    else
      puts "#{event.created_at} #{event.repo.name} : #{event.type}"
    end
end
