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

    class ApiClientResponseError < ApiClientError
      def to_s
        with_status_code_if_present(super)
      end

      private

      def with_status_code_if_present(msg)
        if response && response.respond_to?(:status)
          msg += " (#{response.status})"
        else
          msg
        end
      end
    end

    class Unauthorized < ApiClientResponseError; end
    class Forbidden < ApiClientResponseError; end
    class NotFound < ApiClientResponseError; end
    class Redirect < ApiClientResponseError; end
    class BadRequest < ApiClientResponseError; end
    class Unsupported < ApiClientResponseError; end
    class Conflict < ApiClientResponseError; end
    class ServerError < ApiClientResponseError; end
    class UnprocessableEntity < ApiClientResponseError; end
    class TooManyRequests < ApiClientResponseError; end
  end

end
