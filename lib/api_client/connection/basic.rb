# Faraday for making requests
require 'faraday'

module ApiClient

  module Connection

    class Basic < Abstract

      def create_handler
        # Create and memoize the connection object
        @handler = Faraday.new(@endpoint, @options[:faraday] || {})
        finalize_handler
      end

      def finalize_handler
        @handler.use     Middlewares::Request::Logger, ApiClient.logger if ApiClient.logger
        @handler.use     Faraday::Request::UrlEncoded
        @handler.adapter Faraday.default_adapter
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
        query = Faraday::Utils.build_nested_query(data || {})
        path  = [path, query].join('?') unless query.empty?
        handle_response @handler.get(path, headers)
      end

      #### ApiClient::Connection::Abstract#post
      # Performs a POST request
      # Accepts three parameters:
      #
      # * path - the path request should go to
      # * data - (optional) data sent in the request
      # * headers - (optional) headers sent along in the request
      #
      # This method automatically adds the application token header
      def post(path, data = {}, headers = {})
        handle_response @handler.post(path, data, headers)
      end

      #### ApiClient::Connection::Abstract#put
      # Performs a PUT request
      # Accepts three parameters:
      #
      # * path - the path request should go to
      # * data - (optional) data sent in the request
      # * headers - (optional) headers sent along in the request
      #
      # This method automatically adds the application token header
      def put(path, data = {}, headers = {})
        handle_response @handler.put(path, data, headers)
      end

      #### FS::Connection#delete
      # Performs a DELETE request
      # Accepts three parameters:
      #
      # * path - the path request should go to
      # * data - (optional) the query, passed as a hash and converted into query params
      # * headers - (optional) headers sent along in the request
      #
      # This method automatically adds the application token header
      def delete(path, data = {}, headers = {})
        query = Faraday::Utils.build_nested_query(data || {})
        path  = [path, query].join('?') unless query.empty?
        handle_response @handler.delete(path, headers)
      end

      private

      def handle_response(response)
        raise ApiClient::Errors::ConnectionFailed if !response
        case response.status
          when 401
            raise ApiClient::Errors::Unauthorized
          when 403
            raise ApiClient::Errors::Forbidden
          when 404
            raise ApiClient::Errors::NotFound
          when 400
            raise ApiClient::Errors::BadRequest
          when 406
            raise ApiClient::Errors::Unsupported
          when 422
            raise ApiClient::Errors::UnprocessableEntity.new(response.body)
          when 300..399
            raise ApiClient::Errors::Redirect.new(response['Location'])
          when 500..599
            raise ApiClient::Errors::ServerError
          else
            response
        end
      end

    end
  end
end
