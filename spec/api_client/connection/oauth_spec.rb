require "spec_helper"

describe ApiClient::Connection::Oauth do

  it "uses correct adapter" do
    instance = ApiClient::Connection::Oauth.new("http://google.com")
    if Gem::Version.new(RUBY_VERSION) < Gem::Version.new("2.3")
      expect(instance.handler.builder.handlers.collect(&:name)).to include("Faraday::Adapter::NetHttp")
    else
      expect(instance.handler.builder.adapter.name).to eq("Faraday::Adapter::NetHttp")
    end
  end

  it "adds basic middlewares to faraday" do
    instance = ApiClient::Connection::Oauth.new("http://google.com")
    expect(instance.handler.builder.handlers.collect(&:name))
      .to include("ApiClient::Connection::Middlewares::Request::OAuth", "Faraday::Request::UrlEncoded")
  end

  it "adds the logger middlewares to faraday if ApiClient.logger is available" do
    logger = double
    ApiClient.stub(:logger).and_return(logger)
    instance = ApiClient::Connection::Oauth.new("http://google.com")
    expect(instance.handler.builder.handlers.collect(&:name))
      .to include("ApiClient::Connection::Middlewares::Request::Logger", "ApiClient::Connection::Middlewares::Request::OAuth", "Faraday::Request::UrlEncoded")
  end
end
