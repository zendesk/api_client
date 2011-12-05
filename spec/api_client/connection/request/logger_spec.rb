require "spec_helper"

describe ApiClient::Connection::Middlewares::Request::Logger do

  it "adds a oauth header to the request" do
    app      = mock
    logger   = FakeLogger.new
    instance = ApiClient::Connection::Middlewares::Request::Logger.new(app, logger)
    env = {
      :url => "http://api.twitter.com",
      :request_headers => {},
      :method => 'get'
    }
    app.should_receive(:call).with(env)
    instance.call(env)
    logger.history.first.should == "GET http://api.twitter.com: 0.0000 seconds"
  end

end
