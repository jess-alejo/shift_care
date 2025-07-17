# frozen_string_literal: true

require "json"
require "tempfile"

require_relative "../../lib/builders/json_builder"

RSpec.describe Builders::JsonBuilder do
  let(:valid_data) do
    [
      {
        "id" => 1,
        "full_name" => "Jane Doe",
        "email" => "jane.doe@example.com"
      },
      {
        "id" => 2,
        "full_name" => "Bob Smith",
        "email" => "bob.smith@example.com"
      }
    ]
  end

  def create_tempfile_with_data(data)
    file = Tempfile.new("test_data.json")
    file.write(JSON.pretty_generate(data))
    file.rewind
    file
  end

  context "with valid JSON data" do
    it "parses the clients correctly" do
      file = create_tempfile_with_data(valid_data)
      builder = Builders::JsonBuilder.new(file.path)
      clients = builder.build

      expect(clients.size).to eq(2)
      expect(clients.first).to have_attributes(
        id: 1,
        full_name: "Jane Doe",
        email: "jane.doe@example.com"
      )

      file.close
      file.unlink # Delete the tempfile
    end
  end

  context "with missing fields in JSON" do
    it "builds clients with nil values for missing fields" do
      data = [{ "id" => 1, "email" => "no.name@example.com" }] # full_name missing
      file = create_tempfile_with_data(data)

      builder = Builders::JsonBuilder.new(file.path)
      client = builder.build.first

      expect(client.full_name).to be_nil
      expect(client.email).to eq("no.name@example.com")

      file.close
      file.unlink # Delete the tempfile
    end
  end

  context "with empty JSON array" do
    it "returns an empty array" do
      file = create_tempfile_with_data([])
      builder = Builders::JsonBuilder.new(file.path)

      expect(builder.build).to eq([])

      file.close
      file.unlink
    end
  end

  context "with invalid JSON syntax" do
    it "raises a JSON::ParserError" do
      file = Tempfile.new("invalid.json")
      file.write("{ invalid json }")
      file.rewind

      builder = Builders::JsonBuilder.new(file.path)

      expect { builder.build }.to raise_error(JSON::ParserError)

      file.close
      file.unlink
    end
  end

  context "with non-existent file" do
    it "raises an Errno::ENOENT" do
      builder = Builders::JsonBuilder.new("non_existent_file.json")

      expect { builder.build }.to raise_error(Errno::ENOENT)
    end
  end

  context "with non-array JSON (e.g., hash)" do
    it "raises a TypeError or handles it gracefully" do
      file = create_tempfile_with_data({ message: "Not a list" })

      builder = Builders::JsonBuilder.new(file.path)
      expect { builder.build }.to raise_error(TypeError)

      file.close
      file.unlink
    end
  end
end
