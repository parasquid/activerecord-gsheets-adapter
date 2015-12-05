require "spec_helper"
require "gsheets/oauth/offline"

describe Gsheets::Oauth::Offline do
  Given(:oauth_class) { Gsheets::Oauth::Offline }
  Given(:client_id) { "test_client_id" }
  Given(:client_secret) { "test_client_secret" }

  context "sanity check" do
    When(:instance) { oauth_class.new(client_id, client_secret) }
    Then { instance != nil}
  end

  context "offline authentication" do
    context "getting the authentication uri" do
      Given(:authenticator) { oauth_class.new(client_id, client_secret) }
      When(:authentication_uri) { authenticator.get_authentication_uri }
      Then { authentication_uri.hostname == "accounts.google.com" }
      Then { authentication_uri.path == "/o/oauth2/auth" }
      Then { authentication_uri.query.include? "client_id=test_client_id" }
    end

    Given(:access_token) {
      {
        "access_token"=>"access_token",
        "token_type"=>"Bearer",
        "expires_in"=>3600,
        "refresh_token"=>"refresh_token"
      }
    }
    Given(:signet_spy) { double("Signet::OAuth2::Client", "code=" => nil, "fetch_access_token!" => access_token) }

    context "getting the access token" do
      Given(:authenticator) { oauth_class.new(client_id, client_secret, signet: signet_spy) }
      Given(:authentication_code) { "code" }
      When(:access_token_hash) { authenticator.get_access_token(authentication_code: authentication_code) }
      Then { expect(signet_spy).to have_received(:code=).with(authentication_code) }
      Then { expect(signet_spy).to have_received(:fetch_access_token!) }
      Then { access_token_hash["access_token"] == "access_token" }
      Then { access_token_hash["token_type"] == "Bearer" }
      Then { access_token_hash["expires_in"] == 3600 }
      Then { access_token_hash["refresh_token"] == "refresh_token" }
    end
  end
end