require "active_support"
require "active_support/core_ext"
require "active_record/connection_handling"
require 'active_record/type'

module ActiveRecord
  module ConnectionAdapters
    extend ActiveSupport::Autoload

    autoload :ConnectionSpecification

    autoload_at 'active_record/connection_adapters/abstract/connection_pool' do
      autoload :ConnectionHandler
      autoload :ConnectionManagement
    end

    class AbstractAdapterInterface
      def initialize(connection, logger = nil, pool = nil) #:nodoc:
        super()

        @connection          = connection
        @owner               = nil
        # @instrumenter        = ActiveSupport::Notifications.instrumenter
        @logger              = logger
        @pool                = pool
        @visitor             = nil
        @prepared_statements = false
      end
    end
  end
end