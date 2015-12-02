require "active_support"
require "active_support/core_ext"
require "active_record/connection_adapters/abstract_adapter"

module ActiveRecord
  module ConnectionAdapters
    class GsheetsAdapter < AbstractAdapter
    end
  end
end