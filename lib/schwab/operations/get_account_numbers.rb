require 'schwab/operations/base_operation'

module Schwab; module Operations
  class GetAccountNumbers < BaseOperation

    def call
      perform_api_get_request(url: 'https://api.schwabapi.com/trader/v1/accounts/accountNumbers')
    end

  end
end; end