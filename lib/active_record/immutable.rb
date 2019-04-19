# frozen_string_literal: true

module ActiveRecord
  module Immutable
    extend ActiveSupport::Concern

    DEFAULT_PREVIOUS_VERSION_ID_COLUMN_NAME = 'previous_version_id'

    included do
      def self.default_scope
        where(%{
          NOT EXISTS (
            SELECT 1
            FROM #{quoted_table_name} model
            WHERE model.#{DEFAULT_PREVIOUS_VERSION_ID_COLUMN_NAME} = #{quoted_table_name}.id
          )
        })
      end

      # Overrides ActiveRecord::Persistence#_update_record method
      def _update_record(_attribute_names = attribute_names)
        create_new_version
      end

      def create_new_version
        clone = dup
        clone.previous_version_id = id
        clone.save
      end

      def next_version
        self.class.unscoped.find_by(
          DEFAULT_PREVIOUS_VERSION_ID_COLUMN_NAME => id
        )
      end

      def previous_version
        self.class.unscoped.find(previous_version_id) if previous_version_id.present?
      end
    end
  end
end
