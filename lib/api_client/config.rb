require "hashie"

module ApiClient
  class Config < ::Hashie::Dash
    property :default_headers, :default => {}
  end
end
