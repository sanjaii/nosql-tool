require_relative '../../lib/collection'
require_relative '../../lib/record'

describe Record do
  let(:collection) { [] }
  before(:each) do
    collection = []
  end
  describe 'create' do
    it 'should create a new new record' do
      entry = ['{"Name":"Test", "username":"testuser"}']
      Record.new(collection).create(entry)
      expect(collection.empty?).to be(false)
    end
  end

  describe 'destroy' do
    it 'should delete records with given key value pairs' do
      entry = ['{"Name":"Test", "username":"testuser"}', '{"Name:"Test"}']
      Record.new(collection).create(entry)
      Record.new(collection).destroy(*%w[Name Test])
      expect(collection.empty?).to be(true)
    end
  end

  describe 'search' do
    it 'should returns records with given value ' do
      entry = ['{"Name":"Test", "username":"testuser"}', '{"Name":"Test1"}']
      Record.new(collection).create(entry)
      records = Record.new(collection).search('Test')
      expect(records.empty?).to be(false)
    end
  end

  describe 'select' do
    it 'should returns particular fields from records if all of them exist in a record' do
      entry = ['{"Name":"Test", "username":"testuser"}', '{"Name":"Test1"}']
      Record.new(collection).create(entry)
      records = Record.new(collection).select_records(['Name'])
      expect(records[0]['Name']).to eql('Test')
      expect(records[1]['Name']).to eql('Test1')
      expect(records[0]['username']).to be nil
    end

    it 'should return collection if no keys are specified' do
      entry = ['{"Name":"Test", "username":"testuser"}', '{"Name":"Test1"}']
      Record.new(collection).create(entry)
      records = Record.new(collection).select_records([])
      expect(records).to eql(collection)
    end
  end
end
