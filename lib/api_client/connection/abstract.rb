module ApiClient

  module Connection

    class Abstract

      attr_accessor :endpoint, :handler, :options

      def initialize(endpoint, options = {})
        raise "Cannot instantiate abstract class" if self.class == ApiClient::Connection::Abstract
        @endpoint = endpoint
        @options  = options
        create_handler
      end

      def create_handler
      end

      #### ApiClient::Connection::Abstract#get
      # Performs a GET request
      # Accepts three parameters:
      #
      # * path - the path the request should go to
      # * data - (optional) the query, passed as a hash and converted into query params
      # * headers - (optional) headers sent along with the request
      #
      def get(path, data = {}, headers = {})
      end

      #### ApiClient::Connection::Abstract#post
      # Performs a POST request
      # Accepts three parameters:
      #
      # * path - the path request should go to
      # * data - (optional) data sent in the request
      # * headers - (optional) headers sent along in the request
      #
      def post(path, data = {}, headers = {})
      end

      #### ApiClient::Connection::Abstract#put
      # Performs a PUT request
      # Accepts three parameters:
      #
      # * path - the path request should go to
      # * data - (optional) data sent in the request
      # * headers - (optional) headers sent along in the request
      #
      def put(path, data = {}, headers = {})
      end

      #### FS::Connection#delete
      # Performs a DELETE request
      # Accepts three parameters:
      #
      # * path - the path request should go to
      # * data - (optional) the query, passed as a hash and converted into query params
      # * headers - (optional) headers sent along in the request
      #
      def delete(path, data = {}, headers = {})
      end

      def inspect
        "#<#{self.class} endpoint: \"#{endpoint}\">"
      end
      alias :to_s :inspect

    end
  end
end
