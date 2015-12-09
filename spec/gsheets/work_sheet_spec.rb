require "spec_helper"
require "gsheets/work_sheet"

describe Gsheets::WorkSheet do
  Given(:ws_class) { Gsheets::WorkSheet }
  Given(:api_payload) { <<-JSON
{"version":"1.0","encoding":"UTF-8","feed":{"xmlns":"http://www.w3.org/2005/Atom","xmlns$openSearch":"http://a9.com/-/spec/opensearchrss/1.0/","xmlns$batch":"http://schemas.google.com/gdata/batch","xmlns$gs":"http://schemas.google.com/spreadsheets/2006","id":{"$t":"https://spreadsheets.google.com/feeds/cells/1YOf91Qpe6cK19_zkzBOoQ2IbYbtrIn8au_oFMPKqmcU/default/private/full"},"updated":{"$t":"2015-12-05T12:06:17.850Z"},"category":[{"scheme":"http://schemas.google.com/spreadsheets/2006","term":"http://schemas.google.com/spreadsheets/2006#cell"}],"title":{"type":"text","$t":"Sheet1"},"link":[{"rel":"alternate","type":"application/atom+xml","href":"https://docs.google.com/spreadsheets/d/1YOf91Qpe6cK19_zkzBOoQ2IbYbtrIn8au_oFMPKqmcU/edit"},{"rel":"http://schemas.google.com/g/2005#feed","type":"application/atom+xml","href":"https://spreadsheets.google.com/feeds/cells/1YOf91Qpe6cK19_zkzBOoQ2IbYbtrIn8au_oFMPKqmcU/default/private/full"},{"rel":"http://schemas.google.com/g/2005#post","type":"application/atom+xml","href":"https://spreadsheets.google.com/feeds/cells/1YOf91Qpe6cK19_zkzBOoQ2IbYbtrIn8au_oFMPKqmcU/default/private/full"},{"rel":"http://schemas.google.com/g/2005#batch","type":"application/atom+xml","href":"https://spreadsheets.google.com/feeds/cells/1YOf91Qpe6cK19_zkzBOoQ2IbYbtrIn8au_oFMPKqmcU/default/private/full/batch"},{"rel":"self","type":"application/atom+xml","href":"https://spreadsheets.google.com/feeds/cells/1YOf91Qpe6cK19_zkzBOoQ2IbYbtrIn8au_oFMPKqmcU/default/private/full?alt\u003djson\u0026min-row\u003d1\u0026max-row\u003d1"}],"author":[{"name":{"$t":"tristan.gomez"},"email":{"$t":"tristan.gomez@gmail.com"}}],"openSearch$totalResults":{"$t":"4"},"openSearch$startIndex":{"$t":"1"},"gs$rowCount":{"$t":"100"},"gs$colCount":{"$t":"21"},"entry":[{"id":{"$t":"https://spreadsheets.google.com/feeds/cells/1YOf91Qpe6cK19_zkzBOoQ2IbYbtrIn8au_oFMPKqmcU/default/private/full/R1C1"},"updated":{"$t":"2015-12-05T12:06:17.850Z"},"category":[{"scheme":"http://schemas.google.com/spreadsheets/2006","term":"http://schemas.google.com/spreadsheets/2006#cell"}],"title":{"type":"text","$t":"A1"},"content":{"type":"text","$t":"id"},"link":[{"rel":"self","type":"application/atom+xml","href":"https://spreadsheets.google.com/feeds/cells/1YOf91Qpe6cK19_zkzBOoQ2IbYbtrIn8au_oFMPKqmcU/default/private/full/R1C1"},{"rel":"edit","type":"application/atom+xml","href":"https://spreadsheets.google.com/feeds/cells/1YOf91Qpe6cK19_zkzBOoQ2IbYbtrIn8au_oFMPKqmcU/default/private/full/R1C1/2l7"}],"gs$cell":{"row":"1","col":"1","inputValue":"id","$t":"id"}},{"id":{"$t":"https://spreadsheets.google.com/feeds/cells/1YOf91Qpe6cK19_zkzBOoQ2IbYbtrIn8au_oFMPKqmcU/default/private/full/R1C2"},"updated":{"$t":"2015-12-05T12:06:17.850Z"},"category":[{"scheme":"http://schemas.google.com/spreadsheets/2006","term":"http://schemas.google.com/spreadsheets/2006#cell"}],"title":{"type":"text","$t":"B1"},"content":{"type":"text","$t":"age"},"link":[{"rel":"self","type":"application/atom+xml","href":"https://spreadsheets.google.com/feeds/cells/1YOf91Qpe6cK19_zkzBOoQ2IbYbtrIn8au_oFMPKqmcU/default/private/full/R1C2"},{"rel":"edit","type":"application/atom+xml","href":"https://spreadsheets.google.com/feeds/cells/1YOf91Qpe6cK19_zkzBOoQ2IbYbtrIn8au_oFMPKqmcU/default/private/full/R1C2/a1nun"}],"gs$cell":{"row":"1","col":"2","inputValue":"age","$t":"age"}},{"id":{"$t":"https://spreadsheets.google.com/feeds/cells/1YOf91Qpe6cK19_zkzBOoQ2IbYbtrIn8au_oFMPKqmcU/default/private/full/R1C3"},"updated":{"$t":"2015-12-05T12:06:17.850Z"},"category":[{"scheme":"http://schemas.google.com/spreadsheets/2006","term":"http://schemas.google.com/spreadsheets/2006#cell"}],"title":{"type":"text","$t":"C1"},"content":{"type":"text","$t":"height"},"link":[{"rel":"self","type":"application/atom+xml","href":"https://spreadsheets.google.com/feeds/cells/1YOf91Qpe6cK19_zkzBOoQ2IbYbtrIn8au_oFMPKqmcU/default/private/full/R1C3"},{"rel":"edit","type":"application/atom+xml","href":"https://spreadsheets.google.com/feeds/cells/1YOf91Qpe6cK19_zkzBOoQ2IbYbtrIn8au_oFMPKqmcU/default/private/full/R1C3/erlxrb"}],"gs$cell":{"row":"1","col":"3","inputValue":"height","$t":"height"}},{"id":{"$t":"https://spreadsheets.google.com/feeds/cells/1YOf91Qpe6cK19_zkzBOoQ2IbYbtrIn8au_oFMPKqmcU/default/private/full/R1C4"},"updated":{"$t":"2015-12-05T12:06:17.850Z"},"category":[{"scheme":"http://schemas.google.com/spreadsheets/2006","term":"http://schemas.google.com/spreadsheets/2006#cell"}],"title":{"type":"text","$t":"D1"},"content":{"type":"text","$t":"email"},"link":[{"rel":"self","type":"application/atom+xml","href":"https://spreadsheets.google.com/feeds/cells/1YOf91Qpe6cK19_zkzBOoQ2IbYbtrIn8au_oFMPKqmcU/default/private/full/R1C4"},{"rel":"edit","type":"application/atom+xml","href":"https://spreadsheets.google.com/feeds/cells/1YOf91Qpe6cK19_zkzBOoQ2IbYbtrIn8au_oFMPKqmcU/default/private/full/R1C4/1vihek"}],"gs$cell":{"row":"1","col":"4","inputValue":"email","$t":"email"}}]}}
JSON
  }
  Given(:session) { double("session", get_cells: OpenStruct.new(body: api_payload)) }
  Given(:id) { "id" }
  Given(:grid_id) { "grid_id" }
  context "sanity check" do
    context "instantiation" do
      When(:ws_instance) { ws_class.new(session: session, id: id, grid_id: grid_id) }
      Then { ws_instance != nil }
    end
  end

  context "headers" do
    Given(:ws_instance) { ws_class.new(session: session, id: id, grid_id: grid_id) }
    When(:headers) { ws_instance.headers }
    Then { headers != nil }
    Then { headers.include?("id") }
    Then { headers.include?("age") }
    Then { headers.include?("height") }
    Then { headers.include?("email") }
    Then { headers.size == 4 }
  end
end
