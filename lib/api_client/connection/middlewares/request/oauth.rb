# Borrowed from https://github.com/pengwynn/faraday_middleware/blob/master/lib/faraday/request/oauth.rb
class ApiClient::Connection::Middlewares::Request::OAuth < Faraday::Middleware

  # faraday 2 removed the `dependency` DSL from Faraday::Middleware, so keep
  # the require lazy (inside #call) to preserve the old behaviour of not
  # forcing simple_oauth on consumers that never use the OAuth connection.
  def call(env)
    require 'simple_oauth'
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
