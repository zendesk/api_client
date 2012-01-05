require "spec_helper"

describe ApiClient::Base do

  it "delegates methods to scope" do
    scope = mock
    ApiClient::Base.stub(:scope).and_return(scope)
    [:fetch, :get, :put, :post, :delete, :headers, :endpoint, :options, :adapter, :params, :raw].each do |method|
      scope.should_receive(method)
      ApiClient::Base.send(method)
    end

  end

end