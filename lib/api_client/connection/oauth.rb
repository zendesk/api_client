module ApiClient

  module Connection

    class Oauth < Basic

      def finalize_handler
        @handler.use     Middlewares::Request::Logger, ApiClient.logger if ApiClient.logger
        @handler.use     Middlewares::Request::OAuth,  @options[:oauth]
        @handler.use     Faraday::Request::UrlEncoded
        @handler.adapter Faraday.default_adapter
      end

    end

  end

end
