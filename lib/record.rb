require_relative '../helper'

class Record
  private

  attr_reader :collection

  def initialize(collection)
    @collection = collection
  end

  public

  def create(entries)
    entries.each do |entry|
      collection << JSON.parse(entry)
      logger.info("Created the following record: #{entry} into the collection")
    end
  rescue JSON::ParserError => e
    logger.error(e.message)
    logger.warn('Invalid JSON format')
  end

  def destroy(key, value)
    collection.delete_if { |record| record[key] == value }
    logger.info("Deleted all the records with key:#{key} and value:#{value} if there any")
    logger.info("Updated collection: #{JSON.pretty_generate(collection)}")
  end

  def search(value)
    records = []
    collection.select do |record|
      records << record if record.values.include?(value)
    end
    logger.info("We couldn't find any records with the value `#{value}`") if records.empty?
    records
  end

  def select_records(keys = [])
    return collection if keys.empty?

    records = []
    collection.each do |record|
      records << record.slice(*keys) if (keys - record.keys).empty?
    end
    records
  end
end
