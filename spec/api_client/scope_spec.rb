require "spec_helper"

describe ApiClient::Scope do

  describe 'default_scopes' do

    it "runs the default scopes defined in the scopeable" do
      class DefaultScopeTest < ApiClient::Base
        always do
          params :foo => 1
        end
      end
      instance = ApiClient::Scope.new(DefaultScopeTest)
      instance.params.should == { :foo => 1 }
    end
  end

  describe "#params" do

    it "reads/writes the params and chains nicely" do
      instance = ApiClient::Scope.new(ApiClient::Base)
      instance.params(:foo => 1).params(:moo => 10).should == instance
      instance.params.should == { :foo => 1, :moo => 10 }
    end

  end

  describe "#headers" do

    it "reads/writes the headers and chains nicely" do
      instance = ApiClient::Scope.new(ApiClient::Base)
      instance.headers(:foo => 1).headers(:moo => 10).should == instance
      instance.headers.should == { :foo => 1, :moo => 10 }
    end

  end

  describe "#options" do

    it "reads/writes the headers and chains nicely" do
      instance = ApiClient::Scope.new(ApiClient::Base)
      instance.options(:foo => 1).options(:moo => 10).should == instance
      instance.options.should == { :foo => 1, :moo => 10 }
    end

  end

  describe "connection" do

    it "retuns the connection based on the adapter" do
      instance = ApiClient::Scope.new(ApiClient::Base)
      instance.connection.should be_an_instance_of ApiClient::Connection::Basic
    end

    it "raises an error if adapter was not found" do
      instance = ApiClient::Scope.new(ApiClient::Base)
      lambda {
        instance.adapter("foo").connection
      }.should raise_error
    end

    it "executes connection hooks" do
      AConnectionHook = mock
      class ScopeConnectionHooksTest < ApiClient::Base
      end
      ScopeConnectionHooksTest.connection_hooks = [AConnectionHook]
      instance = ApiClient::Scope.new(ScopeConnectionHooksTest)
      AConnectionHook.should_receive(:call)
      instance.connection
    end

  end

  describe "requests" do

    before do
      @path    = "somepath"
      @params  = { :foo => 1 }
      @headers = { 'token' => 'A' }
    end

    def test_request(method)
      connection = mock
      instance = ApiClient::Scope.new(ApiClient::Base)
      instance.stub(:connection).and_return(connection)
      response = Faraday::Response.new(:body => '{"a": "1"}')
      connection.should_receive(method).with(@path, @params, @headers).and_return(response)
      instance.params(@params).headers(@headers).send(method, @path)
    end

    it "can make any request" do
      connection = mock
      instance = ApiClient::Scope.new(ApiClient::Base)
      instance.stub(:connection).and_return(connection)
      response = Faraday::Response.new(:body => '{"a": "1"}')
      connection.should_receive(:get).with(@path, @params, @headers).and_return(response)
      result = instance.params(@params).headers(@headers).request(:get, @path)
      result.should == {"a"=> "1"}
    end

    it "can make any request and get a raw response" do
      connection = mock
      instance = ApiClient::Scope.new(ApiClient::Base)
      instance.stub(:connection).and_return(connection)
      response = Faraday::Response.new(:body => '{"a": "1"}')
      connection.should_receive(:get).twice.with(@path, @params, @headers).and_return(response)
      result = instance.params(@params).headers(@headers).request(:get, @path, :raw => true)
      result.should == response
      result = instance.raw.params(@params).headers(@headers).request(:get, @path)
      result.should == response
    end

    it "makes a GET request" do
      result = test_request :get
      result.should == {"a"=> "1"}
    end

    it "makes a POST request" do
      result = test_request :post
      result.should == {"a"=> "1"}
    end

    it "makes a PUT request" do
      result = test_request :put
      result.should == {"a"=> "1"}
    end

    it "makes a PUT request" do
      result = test_request :delete
      result.should == {"a"=> "1"}
    end

    describe "fetch" do

      it "performs a get and builds an object" do
        connection = mock
        instance = ApiClient::Scope.new(ApiClient::Base)
        instance.stub(:connection).and_return(connection)
        response = Faraday::Response.new(:body => '{"id": 42}')
        connection.should_receive(:get).with(@path, @params, @headers).and_return(response)
        result = instance.params(@params).headers(@headers).fetch(@path)
        result.should be_an_instance_of(ApiClient::Base)
        result.id.should == 42
      end

    end

  end

  describe "dynamic delegation of scopeable singleton methods" do

    it "dynamically delegates and properly scopes" do
      class DynamicDelegationTest < ApiClient::Base
        def self.some_method
          self.scope.params
        end
      end
      scope = ApiClient::Scope.new(DynamicDelegationTest)
      scope.params(:param => "aaa").some_method.should == { :param => "aaa" }
    end

    it "raises an error if scopeable does not implement the method" do
      scope = ApiClient::Scope.new(ApiClient::Base)
      lambda {
        scope.some_method_the_class_does_not_have
      }.should raise_error(NoMethodError)
    end

  end


end
