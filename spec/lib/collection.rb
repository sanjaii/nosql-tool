# frozen_string_literal: true

require_relative '../../lib/database'
require_relative '../../config'
require_relative '../../lib/collection'
require_relative '../../lib/parse_data'

describe Collection do
  let(:database) { Database.new("#{Dir.pwd}/test.json").create }
  let(:data) { ParseDatabase.new(database).data }
  let(:collection) { Collection.new(data) }
  let(:collection_name) {'Test'}
  before(:each) do
    Database.new("#{Dir.pwd}/test.json").delete
  end

  before do
    Config.new(database).setup
  end

  describe 'create' do
    it 'should create a new collection' do
      collections = collection.create(collection_name)
      expect(collections).to eql({ 'Test' => [] })
    end
  end

  describe 'find' do
    it 'should return collection if it does exist' do
      collection.create(collection_name)
      expect(collection.find('Test')).to be_an_instance_of Array
    end

    it 'should return nil if the collection does not exist' do
      expect(collection.find('Test')).to be nil
    end
  end
end
