require "spec_helper"
require "gsheets/spread_sheet"

describe Gsheets::SpreadSheet do
  Given(:id) { "id" }
  Given(:api_payload) { <<-JSON
{"version":"1.0","encoding":"UTF-8","feed":{"xmlns":"http://www.w3.org/2005/Atom","xmlns$openSearch":"http://a9.com/-/spec/opensearchrss/1.0/","xmlns$gs":"http://schemas.google.com/spreadsheets/2006","id":{"$t":"https://spreadsheets.google.com/feeds/worksheets/1YOf91Qpe6cK19_zkzBOoQ2IbYbtrIn8au_oFMPKqmcU/private/full"},"updated":{"$t":"2015-12-09T10:34:02.448Z"},"category":[{"scheme":"http://schemas.google.com/spreadsheets/2006","term":"http://schemas.google.com/spreadsheets/2006#worksheet"}],"title":{"type":"text","$t":"test spreadsheet title"},"link":[{"rel":"alternate","type":"application/atom+xml","href":"https://docs.google.com/spreadsheets/d/1YOf91Qpe6cK19_zkzBOoQ2IbYbtrIn8au_oFMPKqmcU/edit"},{"rel":"http://schemas.google.com/g/2005#feed","type":"application/atom+xml","href":"https://spreadsheets.google.com/feeds/worksheets/1YOf91Qpe6cK19_zkzBOoQ2IbYbtrIn8au_oFMPKqmcU/private/full"},{"rel":"http://schemas.google.com/g/2005#post","type":"application/atom+xml","href":"https://spreadsheets.google.com/feeds/worksheets/1YOf91Qpe6cK19_zkzBOoQ2IbYbtrIn8au_oFMPKqmcU/private/full"},{"rel":"self","type":"application/atom+xml","href":"https://spreadsheets.google.com/feeds/worksheets/1YOf91Qpe6cK19_zkzBOoQ2IbYbtrIn8au_oFMPKqmcU/private/full?alt\u003djson"}],"author":[{"name":{"$t":"tristan.gomez"},"email":{"$t":"tristan.gomez@gmail.com"}}],"openSearch$totalResults":{"$t":"2"},"openSearch$startIndex":{"$t":"1"},"entry":[{"id":{"$t":"https://spreadsheets.google.com/feeds/worksheets/1YOf91Qpe6cK19_zkzBOoQ2IbYbtrIn8au_oFMPKqmcU/private/full/obw9kek"},"updated":{"$t":"2015-12-09T10:34:02.448Z"},"category":[{"scheme":"http://schemas.google.com/spreadsheets/2006","term":"http://schemas.google.com/spreadsheets/2006#worksheet"}],"title":{"type":"text","$t":"Copy of Sheet1"},"content":{"type":"text","$t":"Copy of Sheet1"},"link":[{"rel":"http://schemas.google.com/spreadsheets/2006#listfeed","type":"application/atom+xml","href":"https://spreadsheets.google.com/feeds/list/1YOf91Qpe6cK19_zkzBOoQ2IbYbtrIn8au_oFMPKqmcU/obw9kek/private/full"},{"rel":"http://schemas.google.com/spreadsheets/2006#cellsfeed","type":"application/atom+xml","href":"https://spreadsheets.google.com/feeds/cells/1YOf91Qpe6cK19_zkzBOoQ2IbYbtrIn8au_oFMPKqmcU/obw9kek/private/full"},{"rel":"http://schemas.google.com/visualization/2008#visualizationApi","type":"application/atom+xml","href":"https://docs.google.com/spreadsheets/d/1YOf91Qpe6cK19_zkzBOoQ2IbYbtrIn8au_oFMPKqmcU/gviz/tq?gid\u003d719321686"},{"rel":"http://schemas.google.com/spreadsheets/2006#exportcsv","type":"text/csv","href":"https://docs.google.com/spreadsheets/d/1YOf91Qpe6cK19_zkzBOoQ2IbYbtrIn8au_oFMPKqmcU/export?gid\u003d719321686\u0026format\u003dcsv"},{"rel":"self","type":"application/atom+xml","href":"https://spreadsheets.google.com/feeds/worksheets/1YOf91Qpe6cK19_zkzBOoQ2IbYbtrIn8au_oFMPKqmcU/private/full/obw9kek"},{"rel":"edit","type":"application/atom+xml","href":"https://spreadsheets.google.com/feeds/worksheets/1YOf91Qpe6cK19_zkzBOoQ2IbYbtrIn8au_oFMPKqmcU/private/full/obw9kek/-n5dx21"}],"gs$colCount":{"$t":"21"},"gs$rowCount":{"$t":"100"}},{"id":{"$t":"https://spreadsheets.google.com/feeds/worksheets/1YOf91Qpe6cK19_zkzBOoQ2IbYbtrIn8au_oFMPKqmcU/private/full/od6"},"updated":{"$t":"2015-12-09T10:34:02.448Z"},"category":[{"scheme":"http://schemas.google.com/spreadsheets/2006","term":"http://schemas.google.com/spreadsheets/2006#worksheet"}],"title":{"type":"text","$t":"Sheet1"},"content":{"type":"text","$t":"Sheet1"},"link":[{"rel":"http://schemas.google.com/spreadsheets/2006#listfeed","type":"application/atom+xml","href":"https://spreadsheets.google.com/feeds/list/1YOf91Qpe6cK19_zkzBOoQ2IbYbtrIn8au_oFMPKqmcU/od6/private/full"},{"rel":"http://schemas.google.com/spreadsheets/2006#cellsfeed","type":"application/atom+xml","href":"https://spreadsheets.google.com/feeds/cells/1YOf91Qpe6cK19_zkzBOoQ2IbYbtrIn8au_oFMPKqmcU/od6/private/full"},{"rel":"http://schemas.google.com/visualization/2008#visualizationApi","type":"application/atom+xml","href":"https://docs.google.com/spreadsheets/d/1YOf91Qpe6cK19_zkzBOoQ2IbYbtrIn8au_oFMPKqmcU/gviz/tq?gid\u003d0"},{"rel":"http://schemas.google.com/spreadsheets/2006#exportcsv","type":"text/csv","href":"https://docs.google.com/spreadsheets/d/1YOf91Qpe6cK19_zkzBOoQ2IbYbtrIn8au_oFMPKqmcU/export?gid\u003d0\u0026format\u003dcsv"},{"rel":"self","type":"application/atom+xml","href":"https://spreadsheets.google.com/feeds/worksheets/1YOf91Qpe6cK19_zkzBOoQ2IbYbtrIn8au_oFMPKqmcU/private/full/od6"},{"rel":"edit","type":"application/atom+xml","href":"https://spreadsheets.google.com/feeds/worksheets/1YOf91Qpe6cK19_zkzBOoQ2IbYbtrIn8au_oFMPKqmcU/private/full/od6/-u3c663"}],"gs$colCount":{"$t":"21"},"gs$rowCount":{"$t":"100"}}]}}
JSON
  }
  Given(:ss_class) { Gsheets::SpreadSheet }
  Given(:session) { double("session") }
  context "sanity check" do
    context "instantiation" do
      When(:ss_instance) { ss_class.new(session: session, id: id) }
      Then { ss_instance != nil }
    end
  end

  context "worksheets" do
    Given(:session) { double("session", get_worksheets: OpenStruct.new(body: api_payload)) }
    Given(:ss_instance) { ss_class.new(session: session, id: id) }
    context "as hash" do
      When(:result) { ss_instance.list_work_sheets }
      Then { result["Copy of Sheet1"] == "obw9kek" }
      Then { result["Sheet1"] == "od6" }
      Then { result.count == 2 }
    end

    context "as objects" do
      When(:result) { ss_instance.worksheets }
      Then { result.count == 2 }
      Then { result.first.respond_to? :headers }
      Then { result.last.respond_to? :headers }
    end
  end
end
