require "spec_helper"

describe ApiClient::Resource::Scope do

  describe "restful requests" do

    class Restful < ApiClient::Resource::Base
    end

    class Restful2 < ApiClient::Resource::Base
      namespace false
    end

    class Restful3 < ApiClient::Resource::Base
      prefix "v1"
    end

    before do
      @instance  = ApiClient::Resource::Scope.new(Restful)
    end

    it "performs a find to fetch one record" do
      response = { "restful" => { "id" => 42 }}
      @instance.should_receive(:get).with('/restfuls/1.json').and_return(response)
      result = @instance.find(1)
      result.should be_an_instance_of(Restful)
      result.id.should == 42
    end

    it "performs a find to fetch one record in raw mode" do
      response = { "restful" => { "id" => 42 }}
      @instance.should_receive(:get).with('/restfuls/1.json').and_return(response)
      result = @instance.raw.find(1)
      result.should == response
    end

    it "performs a find to fetch one record with a prefix if provided" do
      @instance  = ApiClient::Resource::Scope.new(Restful3)
      response = { "restful3" => { "id" => 42 }}
      @instance.should_receive(:get).with('/v1/restful3s/1.json').and_return(response)
      result = @instance.find(1)
      result.should be_an_instance_of(Restful3)
      result.id.should == 42
    end

    it "performs a find_all to fetch many records" do
      response = [{ "restful" => { "id" => 42 } }, { "restful" => { "id" => 112 } }]
      @instance.should_receive(:get).with('/restfuls.json', {}).and_return(response)
      result = @instance.find_all

      result.should be_an_instance_of(Array)
      result.first.should be_an_instance_of(Restful)
      result.first.id.should == 42
      result.last.should be_an_instance_of(Restful)
      result.last.id.should == 112
    end

    it "performs a find_all to fetch many records in raw mode" do
      response = [{ "restful" => { "id" => 42 } }, { "restful" => { "id" => 112 } }]
      @instance.should_receive(:get).with('/restfuls.json', {}).and_return(response)
      result = @instance.raw.find_all
      result.should == response
    end

    it "performs a create to create a new record" do
      response = { "restful" => { "id" => 42, "name" => "Foo" }}
      @instance.should_receive(:post).with('/restfuls.json', {"restful" => {:name => "Foo"} }).and_return(response)
      result = @instance.create(:name => "Foo")
      result.should be_an_instance_of(Restful)
      result.id.should == 42
    end

    it "performs a create to create a new record in raw mode" do
      response = { "restful" => { "id" => 42, "name" => "Foo" }}
      @instance.should_receive(:post).with('/restfuls.json', {"restful" => {:name => "Foo"} }).and_return(response)
      result = @instance.raw.create(:name => "Foo")
      result.should == response
    end

    it "performs a create to create a new record skipping the namespace if it is not present" do
      @instance  = ApiClient::Resource::Scope.new(Restful2)
      response = { "id" => 42, "name" => "Foo" }
      @instance.should_receive(:post).with('/restful2s.json', {:name => "Foo"} ).and_return(response)
      result = @instance.create(:name => "Foo")
      result.should be_an_instance_of(Restful2)
      result.id.should == 42
    end

    it "performs a update to update an existing record" do
      response = { "restful" => { "id" => 42, "name" => "Foo" }}
      @instance.should_receive(:put).with('/restfuls/42.json', {"restful" => {:name => "Foo"} }).and_return(response)
      result = @instance.update(42, :name => "Foo")
      result.should be_an_instance_of(Restful)
      result.id.should == 42
    end

    it "performs a update to update an existing record in raw mode" do
      response = { "restful" => { "id" => 42, "name" => "Foo" }}
      @instance.should_receive(:put).with('/restfuls/42.json', {"restful" => {:name => "Foo"} }).and_return(response)
      result = @instance.raw.update(42, :name => "Foo")
      result.should == response
    end

    it "performs a update to update an existing record skipping the namespace if it is not present" do
      @instance = ApiClient::Resource::Scope.new(Restful2)
      response = { "id" => 42, "name" => "Foo" }
      @instance.should_receive(:put).with('/restful2s/42.json', {:name => "Foo"} ).and_return(response)
      result = @instance.update(42, :name => "Foo")
      result.should be_an_instance_of(Restful2)
      result.id.should == 42
    end

    it "performs a destroy to remove a record" do
      response = { "restful" => { "id" => 42, "name" => "Foo" }}
      @instance.should_receive(:delete).with('/restfuls/42.json').and_return(response)
      result = @instance.destroy(42)
      result.should == true
    end

  end

end
