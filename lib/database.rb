require 'json'

class Database
  private

  attr_reader :destination, :database

  def initialize(destination)
    @destination = destination
  end

  public

  def connection
    @database = File.open(destination, 'r+')
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
  end

  def read
    File.read(destination)
  end

  def write(content)
    File.write(destination, JSON.pretty_generate(content))
  end
end
