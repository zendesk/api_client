module ApiClient

  module Errors
    class ApiClientError < StandardError; end
    class ConnectionFailed < ApiClientError; end
    class Config < ApiClientError; end
    class Unauthorized < ApiClientError; end
    class Forbidden < ApiClientError; end
    class NotFound < ApiClientError; end
    class Redirect < ApiClientError; end
    class BadRequest < ApiClientError; end
    class Unsupported < ApiClientError; end
    class ServerError < ApiClientError; end
    class UnprocessableEntity < ApiClientError; end
  end

end
