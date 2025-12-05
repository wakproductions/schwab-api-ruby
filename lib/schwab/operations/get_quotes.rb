require 'schwab/operations/base_operation'

module Schwab; module Operations
  class GetQuotes < BaseOperation

    FIELDS = %i[quote extended fundamental reference regular]

    def call(symbols: [], fields: [])
      if fields.present? && fields.any? { |field| FIELDS.exclude?(field) }
        raise(ArgumentError, "all fields must be in #{FIELDS}, got #{fields}")
      end

      params = {
        symbols: symbols.join(','),
      }
      params.merge!(fields: fields.join(',')) if fields.present?

      perform_api_get_request(
        url: "https://api.schwabapi.com/marketdata/v1/quotes",
        query: params,
      )
    end

  end
end; end