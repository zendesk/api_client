module ApiClient

  module Mixins

    module Inheritance

      def inherited(subclass)
        subclass.default_scopes   = self.default_scopes.dup
        subclass.connection_hooks = self.connection_hooks.dup

        subclass.namespace          self.namespace
        subclass.format             self.format
      end

    end

  end

end
