module ApiClient

  module Resource

    class Base < ApiClient::Base

      class << self
        extend ApiClient::Mixins::Delegation
        extend ApiClient::Mixins::Configuration

        delegate :find_all, :find, :create, :update, :destroy, :path, :to => :scope

        dsl_accessor :prefix

        def inherited(subclass)
          super
          small_name = NameResolver.resolve(subclass.name)
          subclass.namespace small_name
          subclass.prefix    self.prefix
          subclass.always do
            name    = small_name
            pre_fix = prefix
            path ["", prefix, "#{name}s"].compact.join('/')
          end
        end

        def scope(options = {})
          scope_in_thread || ApiClient::Resource::Scope.new(self).params(options)
        end

      end

      def persisted?
        !!self.id
      end

      def save
        self.persisted? ? remote_update : remote_create
      end

      def destroy
        get_scope.destroy(self.id)
      end

      def payload
        hash = self.to_hash
        hash.delete('id') # This key is never required
        hash
      end

      def remote_update
        get_scope.update(self.id, **payload)
      end

      def remote_create
        get_scope.create(**payload)
      end

      def get_scope
        original_scope || self.class
      end

    end

  end

end
