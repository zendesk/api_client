require "spec_helper"

describe ApiClient::Base do

  it "is a subclass of Hashie::Mash" do
    ApiClient::Base.should inherit_from(Hashie::Mash)
  end

  it "responds to #id" do
    subject.should respond_to("id")
  end

  it "has a nice inspect" do
    subject.update(:id => 1).inspect.should == '#<ApiClient::Base id: 1>'
  end

end