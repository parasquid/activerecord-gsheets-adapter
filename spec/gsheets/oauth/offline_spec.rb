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

    Given(:signet_spy) {
      double(
        "Signet::OAuth2::Client",
        "code=" => nil,
        "refresh_token=" => nil,
        "refresh_token" => "refresh_token",
        "fetch_access_token!" => {refresh_token: "refresh_token"},
        "access_token" => "access_token"
      )
    }

    context "getting tokens" do
      Given(:authenticator) { oauth_class.new(client_id, client_secret, signet_client: signet_spy) }

      context "authentication_code is given" do
        Given(:authentication_code) { "code" }
        When(:access_token) { authenticator.get_access_token(authentication_code: authentication_code) }
        Then { expect(signet_spy).to have_received(:code=).with(authentication_code) }
        Then { expect(signet_spy).to have_received(:fetch_access_token!) }
        Then { access_token == "access_token" }
      end

      context "refresh_token is given" do
        Given(:refresh_token) { "refresh_token" }
        When(:access_token) { authenticator.get_access_token(refresh_token: refresh_token) }
        Then { expect(signet_spy).to have_received(:refresh_token=).with(refresh_token) }
        Then { expect(signet_spy).to have_received(:fetch_access_token!) }
        Then { access_token == "access_token" }
      end

      context "no authentication code provided" do
        When(:access_token) { authenticator.get_access_token() }
        Then { expect(access_token).to have_failed(ArgumentError, /provide/) }
      end

      context "getting the refresh_token" do
        Given(:authentication_code) { "code" }
        When(:refresh_token) { authenticator.get_refresh_token(authentication_code: authentication_code) }
        Then { refresh_token == "refresh_token" }
      end
    end
  end
end