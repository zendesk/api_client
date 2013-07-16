require "spec_helper"

describe ApiClient::Base do

  describe '.always' do

    it "registers a new default_scope" do
      AlwaysTestProc = lambda {}
      class AlwaysTest < ApiClient::Base
        always &AlwaysTestProc
      end
      AlwaysTest.default_scopes.size.should == 1
      AlwaysTest.default_scopes.should == [AlwaysTestProc]
    end

  end

  describe '.scope' do

    it "returns a ApiClient::Scope instance" do
      ApiClient::Base.scope.should be_an_instance_of(ApiClient::Scope)
    end

  end

  describe '.scope_thread_attribute_name' do

    it "returns the key under which all .scoped calls should be stored" do
      ApiClient::Base.scope_thread_attribute_name.should == "ApiClient::Base_scope"
    end

  end

  describe '.scoped' do

    it "stores the scope in the thread context, attached to class name" do
      mock_scope3 = double
      ApiClient::Base.scoped(mock_scope3) do
        Thread.new {
          mock_scope2 = double
          ApiClient::Base.scoped(mock_scope2) do
            ApiClient::Base.scope.should == mock_scope2
            Thread.current[ApiClient::Base.scope_thread_attribute_name].should == [mock_scope2]
          end
        }
        ApiClient::Base.scope.should == mock_scope3
        Thread.current[ApiClient::Base.scope_thread_attribute_name].should == [mock_scope3]
      end
      Thread.new {
        mock_scope = double
        ApiClient::Base.scoped(mock_scope) do
          ApiClient::Base.scope.should == mock_scope
          Thread.current[ApiClient::Base.scope_thread_attribute_name].should == [mock_scope]
        end
      }
    end

  end

end
