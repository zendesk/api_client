module ApiClient

  module Mixins

    module Delegation

      def delegate(*methods)
        hash = methods.pop
        to = hash[:to]
        methods.each do |method|
          class_eval <<-STR
          def #{method}(*args, &block)
            #{to}.#{method}(*args, &block)
          end
          STR
        end
      end

    end

  end

end
