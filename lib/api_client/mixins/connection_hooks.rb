module ApiClient

  module Mixins

    module ConnectionHooks

      attr_accessor :connection_hooks

      def connection(&block)
        @connection_hooks ||= []
        @connection_hooks.push(block) if block
        @connection_hooks
      end

      def connection_hooks
        @connection_hooks || []
      end

    end

  end

end

