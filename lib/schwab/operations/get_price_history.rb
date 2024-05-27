require 'schwab/operations/base_operation'

module Schwab; module Operations
  class GetPriceHistory < BaseOperation

    # Not used right now, but can be used later on for validation
    FREQUENCY_TYPE=[:minute, :daily, :weekly, :monthly]
    PERIOD_TYPE=[:day, :month, :year, :ytd]

    def call(
      symbol,
      period_type: nil,
      period: nil,
      frequency_type: nil,
      frequency: nil,
      end_date: nil, # should be a Date
      start_date: nil, # should be a Date
      need_extended_hours_data: false
    )
      raise(ArgumentError, "Can't use period if using start_date/end_date") if start_date.present? && period.present?

      params = {
        needExtendedHoursData: need_extended_hours_data,
        symbol: symbol
      }

      params.merge!(frequencyType: frequency_type) if frequency_type
      params.merge!(frequency: frequency) if frequency

      params.merge!(periodType: period_type) if period_type
      params.merge!(period: period) if period
      params.merge!(startDate: "#{start_date.strftime('%s')}000") if start_date
      params.merge!(endDate: "#{end_date.strftime('%s')}000") if end_date

      response = perform_api_get_request(
        url: 'https://api.schwabapi.com/marketdata/v1/pricehistory',
        query: params,
      )

      if response["candles"]
        response["candles"].map do |candle|
          if candle["datetime"].is_a? Numeric
            candle["datetime"] = Time.at(candle["datetime"] / 1000)
          end
        end
      end

      response
    end

    private

  end
end; end