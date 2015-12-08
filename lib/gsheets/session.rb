require "hurley"

module Gsheets
  class Session
    attr_reader :connection

    def initialize(auth_code:, http_client: Hurley::Client, alt: "json")
      @auth_code = auth_code
      @alt = alt
      @connection = get_connection(http_client)
    end

    def get_cells(id:)
      @connection.get "cells/#{id}/default/private/full"
    end

    private

    def get_connection(http_client)
      http_client.new "#{sheets_api_endpoint}?access_token=#{@auth_code}&alt=#{@alt}"
    end

    def sheets_api_endpoint
      "https://spreadsheets.google.com/feeds"
    end
  end
end