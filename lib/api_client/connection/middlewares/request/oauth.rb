# Borrowed from https://github.com/pengwynn/faraday_middleware/blob/master/lib/faraday/request/oauth.rb
require 'simple_oauth'

class ApiClient::Connection::Middlewares::Request::OAuth < Faraday::Middleware
  def call(env)
    params = env[:body] || {}
    signature_params = params.reject{ |k,v| v.respond_to?(:content_type) }

    header = SimpleOAuth::Header.new(env[:method], env[:url], signature_params, @options || {})

    env[:request_headers]['Authorization'] = header.to_s
    env[:request_headers]['User-Agent'] = "ApiClient gem v#{ApiClient::VERSION}"

    @app.call(env)
  end

  def initialize(app, options = {})
    @app, @options = app, options
  end

end
