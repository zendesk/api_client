require "spec_helper"

describe ApiClient::Config do
  subject { described_class.new }

  it "inherits from Hashie::Dash" do
    described_class.should inherit_from(Hashie::Dash)
  end
  its(:default_headers) { should be_a(Hash) }
end
