require "spec_helper"

describe ApiClient::Connection::Middlewares::Request::Logger do

  it "adds a oauth header to the request" do
    app      = double
    logger   = FakeLogger.new
    instance = ApiClient::Connection::Middlewares::Request::Logger.new(app, logger)
    env = {
      :url => "http://api.twitter.com",
      :request_headers => {},
      :method => 'get'
    }
    app.should_receive(:call).with(env)
    instance.call(env)
    logger.history.first.include?("GET http://api.twitter.com").should be_true
  end

end
