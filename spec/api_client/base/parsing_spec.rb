require "spec_helper"

require "multi_xml"

describe ApiClient::Base do

  it "parses json if json is set as format" do
    ApiClient::Base.stub(:format).and_return(:json)
    parsed = ApiClient::Base.parse('{"a":"1"}')
    parsed.should == {"a"=> "1"}
  end

  it "parses xml if xml is set as format" do
    ApiClient::Base.stub(:format).and_return(:xml)
    parsed = ApiClient::Base.parse('<a>1</a>')
    parsed.should == {"a"=> "1"}
  end

  it "returns the string if parser is not found" do
    ApiClient::Base.stub(:format).and_return(:unknown)
    parsed = ApiClient::Base.parse('a:1')
    parsed.should == "a:1"
  end

  it "extracts the body of a Faraday::Response if it is provided" do
    response = Faraday::Response.new(:body => '{"a": "1"}')
    ApiClient::Base.stub(:format).and_return(:json)
    parsed = ApiClient::Base.parse(response)
    parsed.should == {"a"=> "1"}

  end




end