require 'schwab/error'
require 'schwab/util'

module Schwab
  module Operations
    class BaseOperation
      include Schwab::Error
      include Util

      HTTP_DEBUG_OUTPUT=ENV['DEBUG_OUTPUT'] # to make live testing easier

      attr_reader :client

      def initialize(client)
        @client = client  # inject dependency of client credentials
      end

      private

      def debug_output?
        HTTP_DEBUG_OUTPUT.to_s == 'true'
      end

      def handle_api_error(response)
        # "Individual App's transactions per seconds restriction, please update to commercial apps for unrestricted tps"
        if response.code == 429
          raise Schwab::RateLimitError.new(response.body)
        elsif response.code == 401
          raise Schwab::NotAuthorizedError.new(response.body)
        end

        error_message = response['errors'].to_s
        raise Schwab::APIError.new("#{response.code}: #{error_message}")
      rescue JSON::ParserError
        raise Schwab::APIError.new(
          "Unable to parse error response from Schwab API: #{response.code} - #{response.body} | #{response}"
        )
      end

      def parse_response(response)
        raise ArgumentError unless response.is_a?(HTTParty::Response)
        handle_api_error(response) unless response_success?(response)

        response.to_h
      end

      def perform_api_get_request(url: , query: nil)
        options = {
          headers: {
            'Authorization': "Bearer #{client.access_token}",
            'Accept': "application/json"
          }
        }
        options.merge!(query: query) if query
        options.merge!(debug_output: $stdout) if debug_output?

        response = HTTParty.get(
          url,
          options
        )

        parse_response(response)
      end

    end
  end
end