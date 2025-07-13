require 'schwab/operations/base_operation'

module Schwab; module Operations
  class GetTransactions < BaseOperation

    TYPES = %w[
      TRADE
      RECEIVE_AND_DELIVER
      DIVIDEND_OR_INTEREST
      ACH_RECEIPT
      ACH_DISBURSEMENT
      CASH_RECEIPT
      CASH_DISBURSEMENT
      ELECTRONIC_FUND
      WIRE_OUT
      WIRE_IN
      JOURNAL
      MEMORANDUM
      MARGIN_CALL
      MONEY_MARKET
      SMA_ADJUSTMENT
    ]

    def call(account_number:, start_date:, end_date:, types:, symbol: nil)
      raise(ArgumentError, "types must be one of #{TYPES}") unless TYPES.include?(types)
      raise(ArgumentError, "start_date and end_date must be Time") unless [start_date, end_date].all?(Time)

      params = {
        startDate: start_date.utc.iso8601,
        endDate: end_date.utc.iso8601,
        types:,
      }
      params.merge!(symbol:) if symbol

      response = perform_api_get_request(
        url: "https://api.schwabapi.com/trader/v1/accounts/#{account_number}/transactions",
        query: params,
        )

      response
    end

  end
end; end