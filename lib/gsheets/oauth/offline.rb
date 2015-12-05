require 'signet/oauth_2/client'

module Gsheets
  module Oauth
    class Offline
      attr_reader :client_id, :client_secret, :scope

      def initialize(client_id, client_secret, scope: 'https://www.googleapis.com/auth/drive', signet: nil)
        @client_id = client_id
        @client_secret = client_secret
        @scope = scope
        @client = signet || get_signet_client
      end

      def get_authentication_uri
        @client.authorization_uri
      end

      def get_access_token(authentication_code:)
        @client.code = authentication_code
        token_hash = @client.fetch_access_token!
      end

      private

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