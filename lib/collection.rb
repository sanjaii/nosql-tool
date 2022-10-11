require_relative '../helper'

class CollectionDoesNotExist < NameError
  def initialize(message = 'The Collection Does Not Exist In The Database')
    super
  end
end

class Collection
  private

  attr_reader :existing_collections

  def initialize(data)
    @existing_collections = data['collections']
  end

  public

  def find(collection)
    raise CollectionDoesNotExist unless existing_collections[collection]

    existing_collections[collection]
  end

  def create(collection)
    existing_collections.merge!({ collection => [] })
    logger.info("Added `#{collection}` collection into the database")
    existing_collections
  end
end
