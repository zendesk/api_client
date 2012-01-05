require "hashie"
require "yajl"

module ApiClient

  class Base < Hashie::Mash

    extend ApiClient::Mixins::Inheritance
    extend ApiClient::Mixins::Instantiation
    extend ApiClient::Mixins::Scoping
    extend ApiClient::Mixins::ConnectionHooks

    class << self
      extend ApiClient::Mixins::Delegation
      extend ApiClient::Mixins::Configuration

      delegate :fetch, :get, :put, :post, :delete, :headers, :endpoint, :options, :adapter, :params, :raw, :to => :scope

      dsl_accessor :format, :namespace

      def subkey_class
        Hashie::Mash
      end

      def parse(response)
        response = response.body if response.is_a?(Faraday::Response)
        if self.format == :json
          Yajl::Parser.parse(response)
        elsif self.format == :xml
          MultiXml.parse(response)
        else
          response
        end
      end

    end

    # Defaults
    self.format :json

    def id
      self['id']
    end

    def inspect
      "#<#{self.class} id: #{self.id}>"
    end

  end

end

