require 'json'

class CollectionDoesNotExist < NameError
end

class Collection
  private

  attr_reader :existing_collections

  def initialize(data)
    @existing_collections = data['collections']
  end

  def logger
    Logger.new($stdout)
  end

  public

  def find(name)
    raise CollectionDoesNotExist, "The Collection: `#{name}` Does Not Exist!" unless existing_collections[name]

    existing_collections[name]
  end

  def create(name)
    existing_collections.merge!({ name => [] })
    logger.info("Added `#{name}` collection into the database")
    existing_collections
  end
end
