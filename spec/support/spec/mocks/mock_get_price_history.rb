require File.join(File.dirname(__FILE__), 'tdameritrade_api_mock_base.rb')

module Schwab
  ; module Spec; module Mocks;
  class MockGetPriceHistory < TDAmeritradeMockBase

    def self.mock_find(symbol: nil, request: { query: {}, headers: {} }, response: { status: 200, body: '' })
      return if webmock_off?

      url_params = build_url_params(request)
      WebMock
        .stub_request(:get, "#{API_BASE_URL}/marketdata/#{symbol}/pricehistory#{url_params}")
        .with(request)
        .to_return(response)
    end

  end
end; end; end