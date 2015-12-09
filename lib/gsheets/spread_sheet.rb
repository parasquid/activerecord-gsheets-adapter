require "gsheets/work_sheet"

module Gsheets
  class SpreadSheet
    def initialize(session:, id:)
      @id = id
      @session = session
    end

    def list_work_sheets
      result = {}
      document["feed"]["entry"].each do |e|
        result[get_title(e)] = get_grid_id_from_link(e["link"])
      end
      result
    end

    def worksheets
      list_work_sheets.keys.map do |title|
        Gsheets::WorkSheet.new(session: @session, id: @id, grid_id: list_work_sheets[title])
      end
    end

    private

    def document
      #TODO: set cache expiry
      @document ||= JSON.parse(@session.get_worksheets(id: @id).body)
    end

    def get_title(entry)
      entry["title"]["$t"]
    end

    def get_self_link(link)
      link.select { |l| l["rel"] == "self" }.first["href"]
    end

    def get_grid_id(self_link)
      self_link.split("/").last
    end

    def get_grid_id_from_link(link)
      self_link = get_self_link(link)
      get_grid_id(self_link)
    end
  end
end