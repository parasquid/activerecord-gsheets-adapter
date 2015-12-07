require "hurley"

module Gsheets
  class Session
    attr_reader :connection

    def initialize(auth_code:, http_client: Hurley::Client)
      @auth_code = auth_code
      @connection = get_connection(http_client)
    end

    private

    def get_connection(http_client)
      http_client.new "#{sheets_api_endpoint}?access_token=#{@auth_code}"
    end

    def sheets_api_endpoint
      "https://spreadsheets.google.com/feeds"
    end
  end
end