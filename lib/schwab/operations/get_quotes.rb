require 'schwab/operations/base_operation'

module Schwab; module Operations
  class GetQuotes < BaseOperation

    FIELDS = %i[quote fundamental]

    def call(symbols: [], fields: nil)
      raise(ArgumentError, 'fields must be :quote or :fundamental') if fields.present? && FIELDS.exclude?(fields)

      params = {
        symbols: symbols.join(','),
      }
      params.merge!(fields:) if fields.present?

      perform_api_get_request(
        url: "https://api.schwabapi.com/marketdata/v1/quotes",
        query: params,
      )
    end

  end
end; end