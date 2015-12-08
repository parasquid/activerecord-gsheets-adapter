module Gsheets
  class SpreadSheet
    def initialize(session:, id:)
      @session = session
      @id = id
    end

    def headers
      document["feed"]["entry"].map {|e| e["content"]["$t"]}
    end

    private

    def document
      @document ||= JSON.parse(@session.get_cells(id: @id))
    end
  end
end