# frozen_string_literal: true

require_relative "../lib/client"
require_relative "../lib/client_search"
require_relative "./support/shared_clients"

RSpec.describe ClientSearch do
  include_context "with sample clients"

  subject(:searcher) { described_class.new(clients) }

  describe "#search" do
    it "returns exact name matches case-insensitive" do
      result = searcher.search("alice santos")

      expect(result.map(&:id)).to contain_exactly(1)
    end

    it "returns partial name matches (case-insensitive)" do
      result = searcher.search("san")

      expect(result.map(&:id)).to contain_exactly(1, 3)
    end

    it "returns no results if no match found" do
      result = searcher.search("nonexistent")

      expect(result).to be_empty
    end

    it "matches full_name regardless of casing" do
      result = searcher.search("Bob CRUZ")

      expect(result.map(&:id)).to contain_exactly(2)
    end

    it "returns all results if query is empty string" do
      result = searcher.search("")

      expect(result.map(&:id)).to contain_exactly(1, 2, 3, 4)
    end
  end
end
