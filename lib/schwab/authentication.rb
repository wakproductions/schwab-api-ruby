require 'schwab/util'
require 'httparty'

module Schwab
  module Authentication
    include Util

    attr_reader :client_id, :secret, :redirect_uri, :authorization_code, :access_token, :refresh_token,
                :access_token_expires_at, :refresh_token_expires_at

    def authorization_header_token
      client_id_and_secret = "#{client_id}:#{secret}"
      Base64.strict_encode64(client_id_and_secret)
    end

    def default_headers
      {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': "Basic #{authorization_header_token}"
      }
    end

    # Return value looks like:
    #     {"expires_in"=>1800,
    #      "token_type"=>"Bearer",
    #      "scope"=>"api",
    #      "refresh_token"=>"LGGun...",
    #      "access_token"=>"I0.b2F...@",
    #      "id_token"=>"eyJ0eXA..."}
    def request_access_token(authorization_grant_code)
      # headers = { 'Content-Type': 'application/x-www-form-urlencoded' } # turns out didn't need this
      options = {
        body: {
          'grant_type': 'authorization_code',
          'code': authorization_grant_code,
          'redirect_uri': redirect_uri
        },
        headers: default_headers
      }

      response = HTTParty.post(
        'https://api.schwabapi.com/v1/oauth/token',
        options
      )

      unless response_success?(response)
        raise Schwab::APIError.new(
          "Unable to retrieve access tokens from API - #{response.code} - #{response.body}"
        )
      end

      update_tokens(response)
      response
    end

    def refresh_access_token
      options = {
        body: {
          grant_type: 'refresh_token',
          refresh_token: refresh_token,
        },
        headers: default_headers
      }

      response = HTTParty.post(
        'https://api.schwabapi.com/v1/oauth/token',
        options
      )

      update_tokens(response)
      response
    end

    private

    def update_tokens(args={})
      raise_error("#{args['error']} - #{args['error_description']}") if args.has_key?('error')

      @access_token = args['access_token']
      @refresh_token = args['refresh_token']
      @access_token_expires_at = Time.now + args['expires_in'].to_i
      @refresh_token_expires_at = 7.days.from_now

      args
    end
  end
end