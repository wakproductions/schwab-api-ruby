require 'schwab/operations/base_operation'

module Schwab; module Operations
  class GetInstrument < BaseOperation

    def call(symbols, projection:)
      symbol = symbols.is_a?(Array) ? symbols.join(',') : symbols

      params = {
        symbol: symbol,
        projection:
      }

      response = perform_api_get_request(
        url: 'https://api.schwabapi.com/marketdata/v1/instruments',
        query: params,
        )

      response
    end

  end
end; end