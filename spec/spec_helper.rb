require 'active_record'
require 'active_record/immutable'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')

ActiveRecord::Schema.define do
  create_table :people, force: true do |t|
    t.string :name
    t.integer ActiveRecord::Immutable::DEFAULT_PREVIOUS_VERSION_ID_COLUMN_NAME
    t.timestamps
  end
end

class Person < ActiveRecord::Base
  include ActiveRecord::Immutable
end
