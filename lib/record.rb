# frozen_string_literal: true

require 'securerandom'
require 'json'
require 'logger'

class Record
  private

  attr_reader :collection

  def initialize(collection)
    @collection = collection
  end

  def logger
    Logger.new($stdout)
  end

  public

  def create(entries)
    entries.each do |entry|
      collection << JSON.parse(entry)
    end
  rescue JSON::ParserError => e
    logger.error(e.message)
    logger.warn("Ensure that you're given input in the right JSON format")
  end

  def destroy(args)
    raise ArgumentError, "Wrong Number of arguments, given #{args.length}, expected 2" unless args.length == 2

    key, value = *args
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
