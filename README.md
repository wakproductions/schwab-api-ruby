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
- [ ] Accounts and Trading
- [ ] Instruments
- [x] Price History
- [x] Real-time Quotes

## Contributions

If you would like to make a contribution, please submit a pull request to the original branch. Feel free to email me Winston Kotzan
at wak@wakproductions.com with any feature requests, bug reports, or feedback.

#### Wish List

* Test Coverage in RSpec

## Support

Please open an issue on Github if you have any problems or questions.

## Release Notes

See CHANGELOG.md