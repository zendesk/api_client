require "spec_helper"

describe ApiClient::Base do

  describe '.connection' do

    it "registers a new connection_hook" do
      ConnectionHookTestProc = lambda {}
      class ConnectionHookTest < ApiClient::Base
        connection &ConnectionHookTestProc
      end
      expect(ConnectionHookTest.connection_hooks.size).to eq(1)
      expect(ConnectionHookTest.connection_hooks).to eq([ConnectionHookTestProc])
    end

  end

end