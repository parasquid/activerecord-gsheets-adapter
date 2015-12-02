require "spec_helper"
require "active_record/connection_adapters/gsheets_adapter"

describe ActiveRecord::ConnectionAdapters::GsheetsAdapter do
  Given(:connection) { "raw_connection" }
  context "sanity check" do
    Given(:adapter) { ActiveRecord::ConnectionAdapters::GsheetsAdapter }
    When(:adapter_instance) { adapter.new(connection) }
    Then { adapter_instance != nil}
  end

  context "initialization" do
    Given(:adapter) { ActiveRecord::ConnectionAdapters::GsheetsAdapter }
    When(:adapter_name) { adapter::ADAPTER_NAME }
    Then { adapter_name == "Google Spreadsheets"}
  end
end