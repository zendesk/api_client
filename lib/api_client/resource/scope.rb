# This class includes methods for calling restful APIs
module ApiClient

  module Resource

    class Scope < ApiClient::Scope

      dsl_accessor :path, :return_self => true

      def format
        @scopeable.format
      end

      def append_format(path)
        format ? [path, format].join('.') : path
      end

      def find(id)
        path = [@path, id].join('/')
        path = append_format(path)
        raw  = get(path)
        scoped(self) do
          @scopeable.build(raw)
        end
      end

      def find_all(params = {})
        path = append_format(@path)
        raw  = get(path, params)
        scoped(self) do
          @scopeable.build(raw)
        end
      end

      def create(params = {})
        path = append_format(@path)
        hash = if @scopeable.namespace
          { @scopeable.namespace => params }
        else
          params
        end
        response = post(path, hash)
        scoped(self) do
          @scopeable.build(response)
        end
      end

      def update(id, params = {})
        path = [@path, id].join('/')
        path = append_format(path)
        hash = if @scopeable.namespace
          { @scopeable.namespace => params }
        else
          params
        end
        response = put(path, hash)
        scoped(self) do
          @scopeable.build(response)
        end
      end

      def destroy(id)
        path = [@path, id].join('/')
        path = append_format(path)
        delete(path)
        true
      end

    end

  end

end
