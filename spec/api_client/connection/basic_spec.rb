require "spec_helper"

describe ApiClient::Connection::Basic do

  it "has a nice inspect" do
    instance = ApiClient::Connection::Basic.new("http://google.com")
    instance.inspect.should == '#<ApiClient::Connection::Basic endpoint: "http://google.com">'
  end

  it "adds basic middlewares to faraday" do
    instance = ApiClient::Connection::Basic.new("http://google.com")
    instance.handler.builder.handlers.collect(&:name).should == ["Faraday::Request::UrlEncoded", "Faraday::Adapter::NetHttp"]
  end

  it "adds the logger middlewares to faraday if ApiClient.logger is available" do
    logger = mock
    ApiClient.stub(:logger).and_return(logger)
    instance = ApiClient::Connection::Basic.new("http://google.com")
    instance.handler.builder.handlers.collect(&:name).should == [
      "ApiClient::Connection::Middlewares::Request::Logger",
      "Faraday::Request::UrlEncoded",
      "Faraday::Adapter::NetHttp"
    ]

  end

  it "creates a Faraday object on initialize" do
    instance = ApiClient::Connection::Basic.new("http://google.com")
    instance.handler.should be_an_instance_of(Faraday::Connection)
  end

  describe "requests" do

    before do
      @instance = ApiClient::Connection::Basic.new("http://google.com")
      @headers  = { "header" => "token" }
      @params   = { "param" => "1", "nested" => { "param" => "1" } }
      @response = Faraday::Response.new(:status => 200)
      @faraday_request_params = mock
      @faraday_request = mock(:params => @faraday_request_params) 
    end

    it "can perform GET requests" do
      @instance.handler.
        should_receive(:run_request).
        with(:get, '/home', nil, @headers).
        and_yield(@faraday_request).
        and_return(@response)
      @faraday_request_params.should_receive(:update).with(@params)
      @instance.get "/home", @params, @headers
    end

    it "can perform POST requests" do
      @instance.handler.
        should_receive(:run_request).
        with(:post, '/home', @params, @headers).
        and_return(@response)
      @instance.post "/home", @params, @headers
    end

    it "can perform PUT requests" do
      @instance.handler.
        should_receive(:run_request).
        with(:put, '/home', @params, @headers).
        and_return(@response)
      @instance.put "/home", @params, @headers
    end

    it "can perform DELETE requests" do
      @instance.handler.
        should_receive(:run_request).
        with(:delete, '/home', nil, @headers).
        and_yield(@faraday_request).
        and_return(@response)
      @faraday_request_params.should_receive(:update).with(@params)
      @instance.delete "/home", @params, @headers
    end

  end

  describe "#handle_response" do

    before do
      @instance = ApiClient::Connection::Basic.new("http://google.com")
      @response = Faraday::Response.new(:status => 200)
    end

    it "raises an ApiClient::Errors::ConnectionFailed if there is no response" do
      lambda {
        @instance.send :handle_response, nil
      }.should raise_error(ApiClient::Errors::ConnectionFailed)
    end

    it "raises an ApiClient::Errors::Unauthorized if status is 401" do
      @response.env[:status] = 401
      lambda {
        @instance.send :handle_response, @response
      }.should raise_error(ApiClient::Errors::Unauthorized)
    end

    it "raises an ApiClient::Errors::Forbidden if status is 403" do
      @response.env[:status] = 403
      lambda {
        @instance.send :handle_response, @response
      }.should raise_error(ApiClient::Errors::Forbidden)
    end

    it "raises an ApiClient::Errors::NotFound if status is 404" do
      @response.env[:status] = 404
      lambda {
        @instance.send :handle_response, @response
      }.should raise_error(ApiClient::Errors::NotFound)
    end

    it "raises an ApiClient::Errors::BadRequest if status is 400" do
      @response.env[:status] = 400
      lambda {
        @instance.send :handle_response, @response
      }.should raise_error(ApiClient::Errors::BadRequest)
    end

    it "raises an ApiClient::Errors::Unsupported if status is 406" do
      @response.env[:status] = 406
      lambda {
        @instance.send :handle_response, @response
      }.should raise_error(ApiClient::Errors::Unsupported)
    end

    it "raises an ApiClient::Errors::Unsupported if status is 422" do
      @response.env[:status] = 422
      lambda {
        @instance.send :handle_response, @response
      }.should raise_error(ApiClient::Errors::UnprocessableEntity)
    end

    it "raises an ApiClient::Errors::Unsupported if status is 300..399" do
      @response.env[:status] = 302
      @response.env[:response_headers] = { 'Location' => "https://google.com" }
      lambda {
        @instance.send :handle_response, @response
      }.should raise_error(ApiClient::Errors::Redirect)
    end

    it "raises an ApiClient::Errors::ServerError if status is 500..599" do
      @response.env[:status] = 502
      lambda {
        @instance.send :handle_response, @response
      }.should raise_error(ApiClient::Errors::ServerError)
    end

  end

end
