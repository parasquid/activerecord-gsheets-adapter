require "active_support"
require "active_support/core_ext"
require "active_record/connection_adapters/abstract_adapter"
require "active_record/connection_handling"

module ActiveRecord
  module ConnectionHandling # :nodoc:

    # TODO
    def gsheets_connection(config)
      # connect to the databased given the config
      # pass in the resulting connection to the adapter
      # so it can be used by active record
      connection = Object.new
      connection_options = {}
      ConnectionAdapters::GsheetsAdapter.new(connection, logger, connection_options, config)
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