require 'fileutils'
require 'logger'

require_relative 'lib/database'

class Config

  private

  attr_reader :database

  def initialize(database)
    @database = database
  end

  def logger
    Logger.new($stdout)
  end

  def scaffold
    { 'collections' => {} }
  end

  public

  def setup
    return unless database.empty?

    logger.info('The database is empty')
    database.write(scaffold)
    logger.info('Added scaffold into the the database')
    database
  end

end
