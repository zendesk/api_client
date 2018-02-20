require "spec_helper"

describe ApiClient::Connection::Middlewares::Request::Logger do
  it "adds a oauth header to the request" do
    app = double
    io = StringIO.new
    logger = Logger.new(io)
    instance = ApiClient::Connection::Middlewares::Request::Logger.new(app, logger)
    env = {
      :url => "http://api.twitter.com",
      :request_headers => {},
      :method => 'get'
    }
    app.should_receive(:call).with(env)
    instance.call(env)
    io.string.should match("GET http://api.twitter.com")
  end
end
