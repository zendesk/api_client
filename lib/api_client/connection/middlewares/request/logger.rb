require "logger"
class ApiClient::Connection::Middlewares::Request::Logger < Faraday::Middleware

  def call(env)
    time    = Time.now
    returns = @app.call(env)
    taken   = Time.now - time
    @logger.info "#{env[:method].to_s.upcase} #{env[:url]}: #{"%.4f" % taken} seconds"
    returns
  end

  def initialize(app, logger = nil)
    @logger = logger || ::Logger.new(STDOUT)
    @app    = app
  end

end
