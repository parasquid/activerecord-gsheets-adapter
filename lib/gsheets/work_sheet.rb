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
      JSON.parse(@session.get_cells(id: @id, grid_id: @grid_id, options: header_row).body)
    end

    def header_row
      ["min-row=1", "max-row=1"]
    end
  end
end