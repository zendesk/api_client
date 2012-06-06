require "spec_helper"

describe ApiClient::Base do

  it "is a subclass of Hashie::Mash" do
    ApiClient::Base.should inherit_from(Hashie::Mash)
  end

  it "responds to #id" do
    subject.should respond_to("id")
  end


  describe "#inspect" do

    it "has a nice inspect" do
      subject.update(:id => 1).inspect.should == '#<ApiClient::Base id: 1>'
    end

    it "presents all fields in inspect" do
      subject.update(:id => 1, :foo => 'OMG')
      subject.inspect.should == '#<ApiClient::Base id: 1, foo: "OMG">'
    end

    it "inspects subobjects properly" do
      subject.update(:id => 1, :sub => [1,2])
      subject.inspect.should == '#<ApiClient::Base id: 1, sub: [1, 2]>'
    end

    it "makes sure id is the first key" do

      subject.update(:foo => 'OMG', :id => 1)
      subject.inspect.should == '#<ApiClient::Base id: 1, foo: "OMG">'
    end

  end

end
