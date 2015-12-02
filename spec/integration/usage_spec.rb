require "spec_helper"
require "active_record"
# require "active_record/connection_adapters/gsheets_adapter"

describe "establishing a connection" do
  Given(:connection) { {adapter: "gsheets"} }
  Given(:ar_base) { ActiveRecord::Base }
  When(:adapter) { ar_base.establish_connection(connection) }
  Then { adapter != nil }
end