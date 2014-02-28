require "hashie"
require "multi_json"

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

      dsl_accessor :format, :namespace, :strict_attr_reader

      def subkey_class
        Hashie::Mash
      end

      def parse(response)
        if response.is_a?(Faraday::Response)
          return nil if response.status == 204
          response = response.body
        end

        if self.format == :json
          MultiJson.load(response)
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
      attributes = []
      attr_keys = self.keys - ['id']
      attributes.push "id: #{self.id}" if self.id
      attr_keys.each do |key|
        attributes.push("#{key}: #{self[key].inspect}")
      end
      "#<#{self.class} #{attributes.join(', ')}>"
    end

    private
    def method_missing(method_name, *args, &blk)
      if respond_to?(method_name)
        super
      else
        if self.class.strict_attr_reader
          fetch(method_name)
        else
          super
        end
      end
    end
  end
end
