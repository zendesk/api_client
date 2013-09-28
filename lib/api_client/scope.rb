module ApiClient

  class Scope
    extend ApiClient::Mixins::Configuration
    extend ApiClient::Mixins::Delegation

    delegate     :prefix, :scoped, :to => :scopeable

    dsl_accessor :endpoint, :adapter, :return_self => true

    attr_reader  :scopeable

    def initialize(scopeable)
      @scopeable  = scopeable
      @params     = {}
      @headers    = {}
      @options    = {}
      @hooks      = @scopeable.connection_hooks || []
      @scopeable.default_scopes.each do |default_scope|
        self.instance_eval(&default_scope)
      end
    end

    def connection
      klass       = Connection.const_get((@adapter || Connection.default).to_s.capitalize)
      @connection = klass.new(@endpoint , @options || {})
      @hooks.each { |hook| hook.call(@connection) }
      @connection
    end

    def raw
      @raw = true
      self
    end

    def raw?
      !!@raw
    end

    # 3 Pillars of scoping
    # options - passed on the the adapter
    # params  - converted to query or request body
    # headers - passed on to the request
    def options(new_options = nil)
      return @options if new_options.nil?
      ApiClient::Utils.deep_merge(@options, new_options)
      self
    end

    def params(options = nil)
      return @params if options.nil?
      ApiClient::Utils.deep_merge(@params, options)  if options
      self
    end
    alias :scope :params

    def headers(options = nil)
      return @headers if options.nil?
      ApiClient::Utils.deep_merge(@headers, options) if options
      self
    end

    def clone_only_headers
      self.class.new(self.scopeable).headers(self.headers)
    end

    # Half-level :)
    # This is a swiss-army knife kind of method, extremely useful
    def fetch(path, options = {})
      scoped(self) do
        @scopeable.build get(path, options)
      end
    end

    # Low-level connection methods

    def request(method, path, options = {})
      options = options.dup

      raw = raw? || options.delete(:raw)
      params(options)
      response = connection.send method, path, @params, @headers
      raw ? response : @scopeable.parse(response)
    end

    def get(path, options = {})
      request(:get, path, options)
    end

    def post(path, options = {})
      request(:post, path, options)
    end

    def put(path, options = {})
      request(:put, path, options)
    end

    def delete(path, options = {})
      request(:delete, path, options)
    end

    # Dynamic delegation of scopeable methods
    def method_missing(method, *args, &block)
      if @scopeable.respond_to?(method)
        @scopeable.scoped(self) do
          @scopeable.send(method, *args, &block)
        end
      else
        super
      end
    end

  end

end
