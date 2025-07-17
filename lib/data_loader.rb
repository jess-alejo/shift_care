# frozen_string_literal: true

require_relative "builders/json_builder"
# CSV/XML builders can be added later

class DataLoader
  def self.load(source:)
    extname = File.extname(source)

    case extname
    when ".json"
      Builders::JsonBuilder.new(source).build
    when ".csv"
      Builders::CsvBuilder.new(source).build
    when ".xml"
      Builders::XmlBuilder.new(source).build
    else
      raise "Unsupported file format: #{extname}"
    end
  end
end
