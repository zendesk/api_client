module ApiClient

  module Mixins

    module Scoping

      attr_accessor :default_scopes

      # Default scoping
      def always(&block)
        default_scopes.push(block) if block
      end

      def default_scopes
        @default_scopes || []
      end

      # Scoping
      def scope(options = {})
        scope_in_thread || Scope.new(self).params(options)
      end

      # Allow wrapping singleton methods in a scope
      # Store the handler in a thread-local variable for thread safety
      def scoped(scope)
        Thread.current[scope_thread_attribute_name] ||= []
        Thread.current[scope_thread_attribute_name].push scope
        begin
          yield
        ensure
          Thread.current[scope_thread_attribute_name] = nil
        end
      end

      def scope_thread_attribute_name
        "#{self.name}_scope"
      end

      def scope_in_thread
        if found = Thread.current[scope_thread_attribute_name]
          found.last
        end
      end

    end

  end

end
