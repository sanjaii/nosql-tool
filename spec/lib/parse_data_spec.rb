require_relative '../../lib/database'
require_relative '../../lib/parse_data'

describe ParseDatabase do
  describe 'data' do
    it 'should parse given databse' do
      database = Database.new("#{Dir.pwd}/test.json").create
      content = { 'test' => 'data' }
      database.write(content)
      expect(ParseDatabase.new(database).data).to eq(content)
    end
  end
end
