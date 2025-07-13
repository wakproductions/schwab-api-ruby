require 'schwab/operations/base_operation'

module Schwab; module Operations
  class GetInstrumentByCusip < BaseOperation

    def call(cusip)
      perform_api_get_request(url: "https://api.schwabapi.com/marketdata/v1/instruments/#{cusip}")
    end

  end
end; end