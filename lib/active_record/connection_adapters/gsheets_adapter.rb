require "active_support"
require "active_support/core_ext"
require "active_record/connection_adapters/abstract_adapter"
require "active_record/connection_handling"

module ActiveRecord
  module ConnectionHandling # :nodoc:
    def gsheets_connection(config)
      ConnectionAdapters::GsheetsAdapter.new(nil, logger, connection_options, config)
    end
  end

  module ConnectionAdapters
    class GsheetsAdapter < AbstractAdapter
      ADAPTER_NAME = "Google Spreadsheets".freeze
      def initialize(connection, logger=nil, connection_options=nil, config={})
        super(connection, logger, config)
      end
    end
  end
end