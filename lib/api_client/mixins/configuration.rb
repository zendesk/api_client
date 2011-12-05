module ApiClient

  module Mixins

    module Configuration

      def dsl_accessor(*names)
        options = names.last.is_a?(Hash) ? names.pop : {}
        names.each do |name|
          returns = options[:return_self] ? "self" : "@#{name}"
          class_eval <<-STR
            def #{name}(value = nil)
              value.nil? ? @#{name} : @#{name} = value
              #{returns}
            end
          STR
        end
      end

    end

  end

end
