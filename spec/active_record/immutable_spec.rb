# frozen_string_literal: true

describe ActiveRecord::Immutable do
  let!(:john_person) { Person.create(name: 'john') }
  let!(:luc_person) { Person.create(name: 'luc', ActiveRecord::Immutable::DEFAULT_PREVIOUS_VERSION_ID_COLUMN_NAME => john_person.id) }
  let!(:liam_person) { Person.create(name: 'liam') }

  describe '.default_scope' do
    it 'should return two people' do
      expect(Person.count).to eq(2)
    end
  end

  describe '#next_version' do
    it 'should return luc person' do
      expect(john_person.next_version).to eq(luc_person)
    end

    it 'should return nil' do
      expect(luc_person.next_version).to be_nil
    end
  end

  describe '#previous_version' do
    it 'should return john person' do
      expect(luc_person.previous_version).to eq(john_person)
    end

    it 'should return nil' do
      expect(john_person.previous_version).to be_nil
    end
  end

  describe '#_update_record' do
    after { john_person.update(name: 'luc') }

    it 'should call create_new_version method' do
      expect(john_person).to receive(:create_new_version)
    end
  end

  describe '#create_new_version' do
    let(:new_name) { 'james' }

    before do
      liam_person.assign_attributes(name: new_name)
      liam_person.create_new_version
    end

    it 'should create a new version with the changes' do
      expect(liam_person.next_version).not_to be_nil
      expect(liam_person.next_version.name).to eq(new_name)
    end
  end
end
