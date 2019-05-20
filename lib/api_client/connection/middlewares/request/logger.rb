require "logger"

class ApiClient::Connection::Middlewares::Request::Logger < Faraday::Middleware
  def call(env)
    debug_lines = []
    should_log_details = @logger.level <= ::Logger::DEBUG

    gather_request_debug_lines(env, debug_lines) if should_log_details

    start = CurrentTimestamp.milis
    response = @app.call(env)
    taken_sec = (CurrentTimestamp.milis - start) / 1000.0

    gather_response_debug_lines(response, taken_sec, debug_lines) if response && should_log_details

    if should_log_details
      debug_lines.each { |line| line.encode!("UTF-8", invalid: :replace, undef: :replace) }
      @logger.debug { debug_lines.join("\n") }
    else
      @logger.info { "#{env[:method].to_s.upcase} #{env[:url]}: #{"%.4f" % taken_sec} seconds" }
    end

    response
  end

  def initialize(app, logger = nil)
    @logger = logger || ::Logger.new(STDOUT)
    @app = app
  end

  private

  def gather_request_debug_lines(env, debug_lines)
    debug_lines << "> #{env[:method].to_s.upcase} #{env[:url]}"
    env[:request_headers].each { |k, v| debug_lines << "> #{k}: #{v}" }
    debug_lines << "> "
    debug_lines << "> #{env[:body]}\n> " if env[:body] && env[:body] != ""
    debug_lines
  end

  def gather_response_debug_lines(response, taken_sec, debug_lines)
    debug_lines << "< responded in #{"%.4f" % taken_sec} seconds with HTTP #{response.status}"
    response.headers.each { |k, v| debug_lines << "< #{k}: #{v}" }
    debug_lines << "< "
    debug_lines << "< #{response.body}\n> " if response.body && response.body != ""
    debug_lines
  end

  class CurrentTimestamp
    class << self
      version = RUBY_VERSION.split('.').map(&:to_i)

      if (version[0] < 2) || (version[0] == 2 && version[1] < 2)
        def milis
          (Time.now.to_f * 1000).to_i
        end
      else
        def milis
          Process.clock_gettime(Process::CLOCK_MONOTONIC, :millisecond)
        end
      end
    end
  end
end
