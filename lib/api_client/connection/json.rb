require 'faraday'

# Exactly like Basic, but uses JSON encoding for request body
# if applicable
module ApiClient
  module Connection
    class Json < Basic
      def finalize_handler
        @handler.use     Middlewares::Request::Logger, ApiClient.logger if ApiClient.logger
        @handler.use     Middlewares::Request::Json
        @handler.use     Faraday::Request::UrlEncoded
        @handler.adapter Faraday.default_adapter
      end
    end
  end
end
