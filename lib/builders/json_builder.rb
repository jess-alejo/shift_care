# frozen_string_literal: true

require 'json'
require_relative '../client'

module Builders
  class JsonBuilder
    def initialize(filepath)
      @filepath = filepath
    end

    def build
      data = JSON.parse(File.read(@filepath))

      data.map do |row|
        Client.new(
          id: row['id'],
          full_name: row['full_name'],
          email: row['email']
        )
      end
    end
  end
end
