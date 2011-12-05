require "spec_helper"

describe ApiClient::Connection::Oauth do

  it "adds basic middlewares to faraday" do
    instance = ApiClient::Connection::Oauth.new("http://google.com")
    instance.handler.builder.handlers.collect(&:name).should == [
      "ApiClient::Connection::Middlewares::Request::OAuth",
      "Faraday::Request::UrlEncoded",
      "Faraday::Adapter::NetHttp"
    ]
  end

  it "adds the logger middlewares to faraday if ApiClient.logger is available" do
    logger = mock
    ApiClient.stub(:logger).and_return(logger)
    instance = ApiClient::Connection::Oauth.new("http://google.com")
    instance.handler.builder.handlers.collect(&:name).should == [
      "ApiClient::Connection::Middlewares::Request::Logger",
      "ApiClient::Connection::Middlewares::Request::OAuth",
      "Faraday::Request::UrlEncoded",
      "Faraday::Adapter::NetHttp"
    ]

  end

end
