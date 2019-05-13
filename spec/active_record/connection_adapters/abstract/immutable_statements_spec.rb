# frozen_string_literal: true

describe ActiveRecord::ConnectionAdapters::ImmutableStatements do
  subject { PersonMigration.new }

  describe '#add_immutable_column' do
    before do
      allow_any_instance_of(migration_instance).to receive(:add_column)
      allow_any_instance_of(migration_instance).to receive(:add_foreign_key)
      allow_any_instance_of(migration_instance).to receive(:add_index)
    end

    after do
      subject.add_immutable_column(
        table_name,
        column_options: column_options,
        foreign_key_options: foreign_key_options,
        index_options: index_options
      )
    end

    let(:table_name) { 'people' }
    let(:column_name) { ActiveRecord::Immutable::DEFAULT_PREVIOUS_VERSION_ID_COLUMN_NAME }
    let(:column_options) { { column_test: 'column_test' } }
    let(:foreign_key_options) { { foreign_key_test: 'foreign_key_test', column: column_name } }
    let(:index_options) { { index_test: 'index_test' } }
    let(:migration_instance) { ActiveRecord::ConnectionAdapters::SchemaStatements }

    it 'creates a column' do
      expect_any_instance_of(migration_instance).to(
        receive(:add_column).with(table_name, column_name, :integer, column_options)
      )
    end

    it 'creates a foreign key' do
      expect_any_instance_of(migration_instance).to(
        receive(:add_foreign_key).with(table_name, table_name, foreign_key_options)
      )
    end

    it 'creates a index' do
      expect_any_instance_of(migration_instance).to(
        receive(:add_index).with(table_name, column_name, index_options)
      )
    end
  end
end
