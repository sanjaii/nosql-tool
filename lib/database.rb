require_relative '../helper'

class DatabaseEmpty < StandardError
end

class Database
  private

  attr_reader :destination, :database

  def initialize(destination)
    @destination = destination
  end

  public

  def connection
    @database = File.open(destination, 'r+')
  rescue Errno::ENOENT
    logger.warn('The database does not exist in the current directory')
  end

  def create
    return self if exist?

    File.new(destination, 'w+')
    logger.info('Created a new database')
    self
  end

  def exist?
    File.exist?(destination)
  end

  def empty?
    File.zero?(destination)
  rescue Errno::ENOENT
    logger.warn('The database does not exist in the current directory')
  end

  def read
    File.read(destination)
  rescue Errno::ENOENT
    logger.warn('The database does not exist in the current directory')
  end

  def write(content)
    File.write(destination, JSON.pretty_generate(content))
  rescue Errno::ENOENT => e
    logger.error(e.message)
  end

  def delete
    File.delete(destination) if exist?
  end
end
