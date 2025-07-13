module Schwab
  class APIError < StandardError
  end

  class RateLimitError < StandardError
  end

  class NotAuthorizedError < StandardError
  end

  class BadRequestError < StandardError
  end

  module Error
    module_function

    def raise_error(message, klass=Schwab::APIError)
      error = klass.new(message)
      error.set_backtrace(caller)
      raise error
    end
  end
end
