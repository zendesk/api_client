module ApiClient

  module Errors
    class ApiClientError < StandardError
      def initialize(message = nil, request = nil, response = nil)
        super(message)
        @request = request
        @response = response
      end

      attr_reader :request, :response
    end

    class ConnectionFailed < ApiClientError; end
    class Config < ApiClientError; end
    class Unauthorized < ApiClientError; end
    class Forbidden < ApiClientError; end
    class NotFound < ApiClientError; end
    class Redirect < ApiClientError; end
    class BadRequest < ApiClientError; end
    class Unsupported < ApiClientError; end
    class Conflict < ApiClientError; end
    class ServerError < ApiClientError; end
    class UnprocessableEntity < ApiClientError; end
    class TooManyRequests < ApiClientError; end
  end

end
