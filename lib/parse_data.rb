require 'json'

class ParseDatabase
  private

  attr_reader :database

  def initialize(database)
    @database = database
  end

  public

  def data
    JSON.parse(database.read)
  end
end
