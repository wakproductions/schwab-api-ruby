require 'schwab/operations/base_operation'

module Schwab; module Operations
  class GetAccounts < BaseOperation

    # Example Response:
    # [
    #   {
    #     "securitiesAccount": {
    #       "type": "CASH",
    #       "accountNumber": "<account1>",
    #       "roundTrips": 0,
    #       "isDayTrader": false,
    #       "isClosingOnlyRestricted": false,
    #       "pfcbFlag": false,
    #       "positions": [
    #         {
    #           "shortQuantity": 0,
    #           "averagePrice": 13.4,
    #           "currentDayProfitLoss": -31.59,
    #           "currentDayProfitLossPercentage": -5.44,
    #           "longQuantity": 39,
    #           "settledLongQuantity": 39,
    #           "settledShortQuantity": 0,
    #           "instrument": {
    #             "assetType": "EQUITY",
    #             "cusip": "83406F102",
    #             "symbol": "SOFI",
    #             "netChange": -0.8
    #           },
    #           "marketValue": 549.51,
    #           "maintenanceRequirement": 0,
    #           "averageLongPrice": 13.4,
    #           "taxLotAverageLongPrice": 13.4,
    #           "longOpenProfitLoss": 26.91,
    #           "previousSessionLongQuantity": 39,
    #           "currentDayCost": 0
    #         },
    #       ],
    #       "initialBalances": {
    #         "accruedInterest": 0,
    #         "cashAvailableForTrading": 1561.98,
    #         "cashAvailableForWithdrawal": 1561.98,
    #         "cashBalance": 1561.98,
    #         "bondValue": 0,
    #         "cashReceipts": 0,
    #         "liquidationValue": 8566.46,
    #         "longOptionMarketValue": 0,
    #         "longStockValue": 7004.48,
    #         "moneyMarketFund": 0,
    #         "mutualFundValue": 1561.98,
    #         "shortOptionMarketValue": 0,
    #         "shortStockValue": 0,
    #         "isInCall": false,
    #         "unsettledCash": 0,
    #         "cashDebitCallValue": 0,
    #         "pendingDeposits": 0,
    #         "accountValue": 8566.46
    #       },
    #       "currentBalances": {
    #         "accruedInterest": 0,
    #         "cashBalance": 1561.98,
    #         "cashReceipts": 0,
    #         "longOptionMarketValue": 0,
    #         "liquidationValue": 8566.46,
    #         "longMarketValue": 7004.48,
    #         "moneyMarketFund": 0,
    #         "savings": 0,
    #         "shortMarketValue": 0,
    #         "pendingDeposits": 0,
    #         "mutualFundValue": 0,
    #         "bondValue": 0,
    #         "shortOptionMarketValue": 0,
    #         "cashAvailableForTrading": 1561.98,
    #         "cashAvailableForWithdrawal": 1561.98,
    #         "cashCall": 0,
    #         "longNonMarginableMarketValue": 1561.98,
    #         "totalCash": 1561.98,
    #         "cashDebitCallValue": 0,
    #         "unsettledCash": 0
    #       },
    #       "projectedBalances": {
    #         "cashAvailableForTrading": 1561.98,
    #         "cashAvailableForWithdrawal": 1561.98
    #       }
    #     },
    #     "aggregatedBalance": {
    #       "currentLiquidationValue": 8566.46,
    #       "liquidationValue": 8566.46
    #     }
    #   },
    def call(fields: 'positions')
      params = {
        fields:,
      }

      response = perform_api_get_request(
        url: 'https://api.schwabapi.com/trader/v1/accounts',
        query: params,
        )

      response
    end

  end
end; end