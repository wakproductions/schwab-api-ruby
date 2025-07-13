require 'schwab/operations/base_operation'

module Schwab; module Operations
  class GetInstrument < BaseOperation

    PROJECTIONS = %w[symbol-search symbol-regex desc-search desc-regex search fundamental]

    def call(symbols, projection:)
      raise ArgumentError, "projection must be in #{PROJECTIONS}" unless PROJECTIONS.include?(projection)

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