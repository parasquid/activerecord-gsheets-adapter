module Gsheets
  class WorkSheet
    def initialize(session:, grid_id: " default", id:)
      @grid_id = grid_id
      @session = session
      @id = id
    end

    def headers
      cells_first_row["feed"]["entry"].map {|e| e["content"]["$t"]}
    end

    private

    def cells_first_row
      #TODO: set cache expiry
      @cells_first_row ||= JSON.parse(@session.get_cells(id: @id, grid_id: @grid_id, options:["min-row=1", "max-row=1"]).body)
    end
  end
end