module ApiClient
  module Mixins
    module Instantiation
      def self.extended(base)
        base.instance_eval do
          attr_accessor :original_scope
        end
      end

      def build_one(hash)
        instance = self.new self.namespace ? hash[namespace] : hash
        instance.original_scope = self.scope.clone_only_headers
        instance
      end

      def build_many(array)
        array.collect { |one| build_one(one) }
      end

      def build(result_or_array)
        if result_or_array.is_a?(Array)
          build_many result_or_array
        else
          build_one  result_or_array
        end
      end
    end
  end
end
