require "hurley"

module Gsheets
  class Session
    def initialize(auth_code:, http_client: Hurley::Client, alt: "json")
      @auth_code = auth_code
      @alt = alt
      @http_client = http_client
    end

    def get_cells(id:, grid_id: "default", options:[])
      connection.get "cells/#{id}/#{grid_id}/private/full?#{options.join('&')}"
    end

    def get_worksheets(id:)
      connection.get "worksheets/#{id}/private/full"
    end

    def connection
      @http_client.new "#{sheets_api_endpoint}?access_token=#{@auth_code}&alt=#{@alt}"
    end

    private

    def sheets_api_endpoint
      "https://spreadsheets.google.com/feeds"
    end
  end
end