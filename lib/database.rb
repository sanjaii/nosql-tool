require 'json'
require 'logger'

class Database
  private

  attr_reader :destination, :database

  def initialize(destination)
    @destination = destination
  end

  def logger
    Logger.new($stdout)
  end

  public

  def connection
    @database = File.open(destination, 'r+')
  rescue Errno::ENOENT
    logger.warn('The database does not exist in the current path')
  end

  def create
    File.new(destination, 'w+')
    self
  end

  def exist?
    File.exist?(destination)
  end

  def empty?
    File.zero?(destination)
  rescue Errno::ENOENT
    logger.warn('The database does not exist in the current path')
  end

  def read
    File.read(destination)
  rescue Errno::ENOENT
    logger.warn('The database does not exist in the current path')
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
