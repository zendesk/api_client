require "spec_helper"

describe ApiClient::Connection::Abstract do

  class ConnectionSubclass < ApiClient::Connection::Abstract
  end

  it "does not raise an error when instantiating a subclass" do
    lambda {
      ConnectionSubclass.new("http://google.com")
    }.should_not raise_error("Cannot instantiate abstract class")
  end

  it "raises an error when instantiating directly and not as a subclass" do
    lambda {
      ApiClient::Connection::Abstract.new("http://google.com")
    }.should raise_error("Cannot instantiate abstract class")
  end

end

