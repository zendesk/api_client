require "spec_helper"

describe ApiClient::Base do

  it "is a subclass of Hashie::Mash" do
    ApiClient::Base.should inherit_from(Hashie::Mash)
  end

  it "responds to #id" do
    subject.should respond_to("id")
  end

  class StrictApi < ApiClient::Base
    def accessor_of_x
      self.x
    end

    def strict_attr_reader?
      true
    end
  end

  class StrictDescendant < StrictApi
  end

  context "when used in an array" do

    subject { [StrictApi.new] }

    it "does not break Array#flatten" do
      lambda { subject.flatten }.should_not raise_error
    end

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
      subject.inspect.should == '#<ApiClient::Base id: 1, sub: #<Hashie::Array [1, 2]>>'
    end

    it "makes sure id is the first key" do

      subject.update(:foo => 'OMG', :id => 1)
      subject.inspect.should == '#<ApiClient::Base id: 1, foo: "OMG">'
    end

  end

  describe "strict_read" do
    it "fails if the key is missing and strict_read is set" do
      api = StrictApi.new
      lambda { api.missing }.should raise_error do |error|
        error_type = error.class.to_s
        error_type.should match(/KeyError|IndexError/)
      end
    end

    it "doesn't fail if strict_read is not set" do
      api = ApiClient::Base.new
      api.missing
    end

    it "doesn't fail if the key was set after object was created" do
      api = StrictApi.new
      lambda { api.not_missing = 1 }.should_not raise_error
      api.not_missing.should == 1
    end

    it "doesn't fail for predicate methods if key is not set" do
      api = StrictApi.new
      lambda { api.missing? }.should_not raise_error
      api.missing?.should be_false
    end

    it "allows to call methods" do
      api = StrictApi.new(:x => 14)
      api.accessor_of_x.should == 14
    end

    it "calling method which asks for missing attribute fails" do
      api = StrictApi.new
      lambda { api.accessor_of_x }.should raise_error do |error|
        error_type = error.class.to_s
        error_type.should match(/KeyError|IndexError/)
      end
    end

    it "passes strict api configuration to subclasses" do
      api = StrictDescendant.new
      lambda { api.missing }.should raise_error do |error|
        error_type = error.class.to_s
        error_type.should match(/KeyError|IndexError/)
      end
    end
  end
end
