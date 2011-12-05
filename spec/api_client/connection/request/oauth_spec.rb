require "spec_helper"

describe ApiClient::Connection::Middlewares::Request::OAuth do

  it "adds a oauth header to the request" do
    app = mock
    options = {
      :token => 'TOKEN',
      :token_secret => 'SECRET',
      :consumer_key => 'CONSUMER_KEY',
      :consumer_secret => 'CONSUMER_SECRET'
    }
    instance = ApiClient::Connection::Middlewares::Request::OAuth.new(app, options)
    env = {
      :url => "http://api.twitter.com",
      :request_headers => {}
    }
    app.should_receive(:call).with(env)

    instance.call(env)
    env[:request_headers]['Authorization'].should match("OAuth")
    env[:request_headers]['User-Agent'].should match("ApiClient gem")

  end

end
