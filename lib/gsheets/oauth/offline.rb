require 'signet/oauth_2/client'

module Gsheets
  module Oauth
    class Offline
      attr_reader :client_id, :client_secret, :scope, :signet_client

      def initialize(
        client_id,
        client_secret,
        scope: default_scopes,
        signet_client: nil
      )
        @client_id = client_id
        @client_secret = client_secret
        @scope = scope
        @signet_client = signet_client || get_signet_client
      end

      def get_authentication_uri
        @signet_client.authorization_uri
      end

      def get_access_token(authentication_code: nil, refresh_token: nil)
        error_message = "you must provide either an authentication_code or refresh_token".freeze
        raise ArgumentError, error_message if authentication_code.nil? && refresh_token.nil?
        @signet_client.code = authentication_code if authentication_code
        @signet_client.refresh_token = refresh_token if refresh_token
        @signet_client.fetch_access_token!
        @signet_client.access_token
      end

      def get_refresh_token(authentication_code:)
        @signet_client.code = authentication_code
        @signet_client.fetch_access_token!
        @signet_client.refresh_token
      end

      private

      def default_scopes
        [
          "https://www.googleapis.com/auth/drive",
          "https://www.googleapis.com/auth/drive.file",
          "https://www.googleapis.com/auth/drive.metadata",
          "https://spreadsheets.google.com/feeds",
          "https://docs.google.com/feeds"
        ]
      end

      def get_signet_client
        Signet::OAuth2::Client.new(
          authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
          token_credential_uri:  'https://www.googleapis.com/oauth2/v3/token',
          client_id: client_id,
          client_secret: client_secret,
          :scope => scope,
          :redirect_uri => 'urn:ietf:wg:oauth:2.0:oob'
        )
      end
    end
  end
end