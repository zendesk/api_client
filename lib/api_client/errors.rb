module ApiClient

  module Errors
    class ConnectionFailed < Exception; end
    class Config < Exception; end
    class Unauthorized < Exception; end
    class Forbidden < Exception; end
    class NotFound < Exception; end
    class Redirect < Exception; end
    class BadRequest < Exception; end
    class Unsupported < Exception; end
    class ServerError < Exception; end
    class UnprocessableEntity < Exception; end
  end

end
