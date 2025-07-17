# frozen_string_literal: true

require_relative "../lib/client"
require_relative "../lib/duplicate_checker"
require_relative "./support/shared_clients"

RSpec.describe DuplicateChecker do
  include_context "with sample clients"

  subject(:checker) { described_class.new(clients) }

  describe "#find_duplicates" do
    it "returns grouped duplicates by email" do
      duplicates = checker.find_duplicates

      expect(duplicates.keys).to contain_exactly("bob.cruz@example.com")
    end

    it "returns exmpty hash if there are no duplicates" do
      unique_clients = clients.reject { |c| c.email == "bob.cruz@example.com" }
      checker = described_class.new(unique_clients)

      expect(checker.find_duplicates).to eq({})
    end

    it "detects mutiple duplicate groups" do
      mutiple = clients + [
        Client.new(id: 5, full_name: "Another Alice", email: "alice.santos@example.com")
      ]

      checker = described_class.new(mutiple)

      result = checker.find_duplicates
      expect(result.keys).to match_array(["alice.santos@example.com", "bob.cruz@example.com"])
      expect(result["alice.santos@example.com"].map(&:id)).to include(1, 5)
    end

    it "treats email case-sensitively by default" do
      casey = clients + [
        Client.new(id: 6, full_name: "Bob Clone", email: "bob.CRUZ@example.com")
      ]

      checker = described_class.new(casey)

      result = checker.find_duplicates
      expect(result.keys).to contain_exactly("bob.cruz@example.com")
    end
  end
end
