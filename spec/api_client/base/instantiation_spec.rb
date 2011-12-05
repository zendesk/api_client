require "spec_helper"

describe ApiClient::Base do

  describe "build" do

    it "instantiates an array of objects and returns an array if passed an array" do
      result = ApiClient::Base.build [{ :id => 1 }, { :id => 2}]
      result.should be_an_instance_of(Array)
      result.first.should be_an_instance_of(ApiClient::Base)
      result.last.should  be_an_instance_of(ApiClient::Base)
    end

    it "instantiates an object and returns an object if passed an object" do
      result = ApiClient::Base.build({ :id => 1 })
      result.should be_an_instance_of(ApiClient::Base)
    end

  end

  describe "build_one" do

    it "extracts the attributes from a namespace if a namespace is provided" do
      ApiClient::Base.stub(:namespace).and_return("base")
      result = ApiClient::Base.build({ "base" => { :id => 1 } })
      result.should be_an_instance_of(ApiClient::Base)
      result.keys.should == ['id']
      result.id.should   == 1
    end

  end

  describe "sub hashes" do

    it "are Hashie::Mashes" do
      result = ApiClient::Base.build({ :id => 1, :subhash => { :foo => 1 } })
      result.subhash.should be_an_instance_of(Hashie::Mash)
    end

  end

  describe "original_scope" do

    it "holds the original scope it was created from" do

      scope = ApiClient::Base.params(:foo => 1).headers('token' => 'aaa')
      instance = scope.build :key => 'value'
      instance.original_scope.should == scope

    end

  end

end