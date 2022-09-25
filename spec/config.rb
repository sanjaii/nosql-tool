require_relative '../config'
require_relative '../lib/database'

describe Config do
  describe 'setup' do
    database = Database.new("#{Dir.pwd}/test.json").create
    it 'creates a new database and add scaffold if it is not exisisting' do
      Config.new(database).setup
      expect(database.empty?).to be(false)
    end
  end
end
