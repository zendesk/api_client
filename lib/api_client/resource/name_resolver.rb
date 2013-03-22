module ApiClient
  module Resource
    class NameResolver
      def self.resolve(ruby_path)
        new(ruby_path).resolve
      end

      attr_reader :name

      def initialize(name)
        @name = name
      end

      def resolve
        select_last_item
        underscorize
        lowercase
        name
      end

      private
      def select_last_item
        @name = @name.split('::').last
      end

      #Inspired by ActiveSupport::Inflector#underscore
      def underscorize
        @name.gsub!(/([A-Z\d]+)([A-Z][a-z])/,'\1_\2')
        @name.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
      end

      def lowercase
        @name.downcase!
      end
    end
  end
end
