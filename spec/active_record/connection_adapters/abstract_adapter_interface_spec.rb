require "spec_helper"
require "active_record/connection_adapters/abstract_adapter_interface"

describe ActiveRecord::ConnectionAdapters::AbstractAdapterInterface do
  context "sanity check" do
    Given(:adapter_class) { ActiveRecord::ConnectionAdapters::AbstractAdapterInterface }
    Given(:connection) { "raw_connection" }
    When(:adapter_instance) { adapter_class.new(connection) }
    Then { adapter_instance != nil }
  end
end