require "spec_helper"

describe ApiClient::Resource::Base do

  describe '.scope' do

    it "is an instance of ApiClient::Resource::Scope" do
      ApiClient::Resource::Base.scope.should be_an_instance_of(ApiClient::Resource::Scope)
    end

  end


  describe "persistence" do

    before do
      @instance = ApiClient::Resource::Base.new
      @instance.id = 42
      @instance.name = "Mike"
    end

    describe '#persisted?' do

      it "returns true if id is present, false otherwise" do
        @instance.id = 42
        @instance.persisted?.should == true
        @instance.id = nil
        @instance.persisted?.should == false
      end

    end

    describe '#save' do

      it "creates a record if not persisted" do
        @instance.id = nil
        @instance.should_receive(:remote_create)
        @instance.save
      end

      it "updates a record if not persisted" do
        @instance.id = 42
        @instance.should_receive(:remote_update)
        @instance.save
      end

    end

    describe "#destroy" do

      it "delegates the destroy to the class" do
        ApiClient::Resource::Base.should_receive(:destroy).with(42)
        @instance.destroy
      end

      it "retains the original scope" do
        @instance.original_scope = double
        @instance.original_scope.should_receive(:destroy).with(42)
        @instance.destroy
      end

    end

    describe "#remote_update" do

      it "delegates the update to the class" do
        ApiClient::Resource::Base.should_receive(:update).with(42, { "name" => "Mike" })
        @instance.remote_update
      end

      it "retains the original scope" do
        ApiClient::Resource::Base.stub(:update)
        @instance.original_scope = double
        @instance.original_scope.should_receive(:update).with(42, { "name" => "Mike" })
        @instance.remote_update
      end

    end

    describe "#remote_create" do

      it "delegates the create to the class" do
        ApiClient::Resource::Base.should_receive(:create).with({ "name" => "Mike" })
        @instance.remote_create
      end

      it "retains the original scope" do
        @instance.original_scope = double
        @instance.original_scope.should_receive(:create).with({ "name" => "Mike" })
        @instance.remote_create
      end

    end

  end

end
