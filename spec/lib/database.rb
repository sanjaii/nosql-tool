require_relative '../../lib/database'
require_relative '../../config'
require_relative '../../lib/parse_data'

describe Database do
  before(:each) do
    Database.new("#{Dir.pwd}/test.json").delete
  end

  describe 'create' do
    it 'should create new database' do
      database = Database.new("#{Dir.pwd}/test.json").create
      expect(database.exist?).to be(true)
      expect(database.empty?).to be(true)
    end
  end

  describe 'empty?' do
    it 'should retrurn true for new databae' do
      database = Database.new("#{Dir.pwd}/test.json").create
      expect(database.empty?).to be(true)
    end

    it 'should retrurn false if data exist' do
      database = Database.new("#{Dir.pwd}/test.json").create
      content = { 'test' => 'data' }
      database.write(content)
      expect(database.empty?).to be(false)
    end
  end

  describe 'exist?' do
    it 'should retrurn true if database exist' do
      database = Database.new("#{Dir.pwd}/test.json").create
      expect(database.exist?).to be(true)
    end

    it 'should retrurn false if the database does not exist' do
      database = Database.new("#{Dir.pwd}/test.json")
      expect(database.exist?).to be(false)
    end
  end

  describe 'write' do
    it 'should write content into the database' do
      database = Database.new("#{Dir.pwd}/test.json")
      content = { 'test' => 'data' }
      database.write(content)
      data = ParseDatabase.new(database).data
      expect(data).to eq(content)
    end
  end

  describe 'delete' do
    it 'should delete the database if it exist' do
      database = Database.new("#{Dir.pwd}/test.json").create
      database.delete
      expect(database.exist?).to be(false)
    end
  end

  describe 'read' do
    it 'should read contents in the database' do
      database = Database.new("#{Dir.pwd}/test.json").create
      expect(database.read).to eql('')
    end
  end
end
