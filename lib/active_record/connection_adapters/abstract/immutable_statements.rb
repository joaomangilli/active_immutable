# frozen_string_literal: true

require 'active_record/immutable'

module ActiveRecord
  module ConnectionAdapters
    module ImmutableStatements
      extend ActiveSupport::Concern

      included do
        def add_immutable_column(table_name, options = {})
          column_name = ActiveRecord::Immutable::DEFAULT_PREVIOUS_VERSION_ID_COLUMN_NAME

          add_column(table_name, column_name, :integer, options.fetch(:column_options, {}))

          add_foreign_key(
            table_name,
            table_name,
            options.fetch(:foreign_key_options, {}).merge(column: column_name)
          )

          add_index(table_name, column_name, options.fetch(:index_options, {}))
        end
      end
    end
  end
end
