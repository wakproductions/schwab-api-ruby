# TD Ameritrade API gem for Ruby

This is a gem for connecting to the OAuth/JSON-based Schwab API released in 2018. Go to
https://beta-developer.schwab.com/ to create your OAuth application login and view the official documentation.

For a gem that allows you to connect to the older version of the TDAmeritrade API, go to 
https://github.com/wakproductions/tdameritrade_api

## Installation

In your Gemfile

`gem 'schwab-api-ruby', git: 'https://github.com/wakproductions/schwab-api-ruby.git'`

## Authenticating

Currently this gem is designed for local app authorization of the "Trader API - Individual". It is based on the
assumption that you will be using https://127.0.0.1 as the OAuth redirect_uri, as that is the only value that's
been tested and verified to work

## Basic Usage

```
client = SchwabAPI::Client.new(
  client_id: <client_id>, 
  redirect_uri: 'https://127.0.0.1', 
  refresh_token: '<refresh_token>'
)

client.get_instrument_fundamentals('MSFT')
#=> {"MSFT"=>
      {"fundamental"=>
        {"symbol"=>"MSFT",
         "high52"=>425.24,
         "low52"=>340.33,
         ...
```

# Current State of Functionality

The official API is documented [here](https://developer.tdameritrade.com/apis). This gem currently implements the
following functionality. If you would like to expand its functionality, then please submit a pull request.

- [x] Authentication
- [X] Accounts and Trading
- [X] Instruments
- [x] Price History
- [x] Real-time Quotes

The following functions correspond to the Schwab Individual Trader API specification found in the online docs:
* get_accounts(fields=nil)
* get_account_numbers
* get_instrument(symbol, projection)
* get_instrument_by_cusip(cusip)
* get_price_history(symbol, **options)
* get_quotes(symbols, **options)
* get_transactions(...)

# Example usage

```ruby
client = Schwab::Client.new(
  client_id: ENV.fetch('SCHWAB_CLIENT_ID'),
  secret: ENV.fetch('SCHWAB_SECRET'),
  redirect_uri: ENV.fetch('SCHWAB_REDIRECT_URI'),
  access_token: '<access token you received after running the OAuth authentication step>',
  refresh_token: '<access token you received after running the OAuth authentication step>',
  access_token_expires_at:,
  refresh_token_expires_at:
)

symbols = %w[SCHW HOOD MS]
result = client.get_quotes(symbols, fields: :quote)
#=> {"SCHW" =>
# {"assetMainType" => "EQUITY",
#  "assetSubType" => "COE",
#  "quoteType" => "NBBO",
#  "realtime" => true,
#  "ssid" => 1516105793,
#  "symbol" => "SCHW",
#  "quote" =>
#    {"52WeekHigh" => 93.35,
#     "52WeekLow" => 61.01,
#     "askMICId" => "ARCX",
#     "askPrice" => 92.0,
#     "askSize" => 1,
#     "askTime" => 1752276764663,
#     "bidMICId" => "ARCX",
#     "bidPrice" => 91.5,
#     "bidSize" => 1,
#     "bidTime" => 1752278152374,
#     "closePrice" => 93.04,
#     "highPrice" => 92.99,
#     "lastMICId" => "ARCX",
#     "lastPrice" => 91.8,
#     "lastSize" => 5,
#     "lowPrice" => 91.825,
#     "mark" => 91.97,
#     "markChange" => -1.07,
#     "markPercentChange" => -1.15004299,
#     "netChange" => -1.24,
#     "netPercentChange" => -1.3327601,
#     "openPrice" => 92.53,
#     "postMarketChange" => -0.17,
#     "postMarketPercentChange" => -0.18484288,
#     "quoteTime" => 1752278152374,
#     "securityStatus" => "Normal",
#     "totalVolume" => 6815842,
#     "tradeTime" => 1752277607998}}}
```


## Contributions

If you would like to make a contribution, please submit a pull request to the original branch. Feel free to email me Winston Kotzan
at wak@wakproductions.com with any feature requests, bug reports, or feedback.

#### Wish List

* Test Coverage in RSpec

## Support

Please open an issue on Github if you have any problems or questions.

## Release Notes

See CHANGELOG.md