require "api_client/version"
module ApiClient
  class << self
    attr_accessor :logger
  end

  autoload :Base,          "api_client/base"
  autoload :Errors,        "api_client/errors"
  autoload :Scope,         "api_client/scope"
  autoload :Utils,         "api_client/utils"

  module Mixins
    autoload :ConnectionHooks, "api_client/mixins/connection_hooks"
    autoload :Delegation,      "api_client/mixins/delegation"
    autoload :Configuration,   "api_client/mixins/configuration"
    autoload :Inheritance,     "api_client/mixins/inheritance"
    autoload :Instantiation,   "api_client/mixins/instantiation"
    autoload :Scoping,         "api_client/mixins/scoping"
  end

  module Resource
    autoload :Base,          "api_client/resource/base"
    autoload :Scope,         "api_client/resource/scope"
  end

  module Connection

    class << self
      attr_accessor :default
    end
    self.default = :basic

    module Middlewares
      module Request
        autoload :OAuth,  "api_client/connection/middlewares/request/oauth"
        autoload :Logger, "api_client/connection/middlewares/request/logger"
      end
    end

    autoload :Abstract, "api_client/connection/abstract"
    autoload :Basic,    "api_client/connection/basic"
    autoload :Oauth,    "api_client/connection/oauth"
  end

end
