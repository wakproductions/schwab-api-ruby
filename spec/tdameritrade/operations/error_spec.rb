require 'spec_helper'
require 'support/authenticated_client'
require 'schwab'

describe Schwab::Error do
  include_context 'authenticated client'
  # include_context 'webmock off'

  pending 'rate limit error' do
    subject do
      client.get_quotes(symbols)
    end

    let(:symbols) { %w(PG MSFT CVX) }

    let!(:expected_request) do
      Schwab::Spec::Mocks::MockGetQuotes.mock_find(
        request: {
          headers: { 'Authorization': "Bearer #{client.access_token}" },
          query: {
            apikey: client.client_id,
            symbol: symbols.join(','),
          }.map {|k,v| [k, v.to_s] }.to_h,
        },
        response: {
          status: 429,
          body: <<~RESPONSE
            {"error":"Rate limit error"}
          RESPONSE
        }
      )
    end

    let(:expected_result) do
    end

    it 'raises a RateLimitError' do
      expect { subject }.to raise_error(Schwab::RateLimitError)
    end
  end

  pending 'access token is invalid or expired' do
    subject do
      client.get_quotes(symbols)
    end

    let(:symbols) { %w(PG MSFT CVX) }

    let!(:expected_request) do
      Schwab::Spec::Mocks::MockGetQuotes.mock_find(
        request: {
          headers: { 'Authorization': "Bearer #{client.access_token}" },
          query: {
            apikey: client.client_id,
            symbol: symbols.join(','),
          }.map {|k,v| [k, v.to_s] }.to_h,
        },
        response: {
          status: 401,
          body: <<~RESPONSE
            {"error":"Not Authorized."}
          RESPONSE
        }
      )
    end

    let(:expected_result) do
    end

    it 'raises a NotAuthorizedError' do
      expect { subject }.to raise_error(Schwab::NotAuthorizedError)
    end
  end

end