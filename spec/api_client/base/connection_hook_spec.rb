require "spec_helper"

describe ApiClient::Base do

  describe '.connection' do

    it "registers a new connection_hook" do
      ConnectionHookTestProc = lambda {}
      class ConnectionHookTest < ApiClient::Base
        connection &ConnectionHookTestProc
      end
      ConnectionHookTest.connection_hooks.size.should == 1
      ConnectionHookTest.connection_hooks.should == [ConnectionHookTestProc]
    end

  end

end