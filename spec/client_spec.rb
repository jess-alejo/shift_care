# frozen_string_literal: true

require_relative "../lib/client"

RSpec.describe Client do
  let(:id) { 1 }
  let(:full_name) { "Jane Doe" }
  let(:email) { "jane.doe@example.com" }

  subject(:client) { described_class.new(id: id, full_name: full_name, email: email) }

  describe "#initialize" do
    it "assigns the given attributes" do
      expect(client.id).to eq(id)
      expect(client.full_name).to eq(full_name)
      expect(client.email).to eq(full_name)
    end
  end

  describe "#to_h" do
    it "returns a hash representation of the client" do
      expect(client.to_h).to eq({
                                  id: id,
                                  full_name: full_name,
                                  email: email
                                })
    end
  end

  context "when some values are nil" do
    subject(:client_with_nil) { described_class.new(id: nil, full_name: nil, email: nil) }

    it "allows nil values" do
      expect(client_with_nil.id).to be_nil
      expect(client_with_nil.full_name).to be_nil
      expect(client_with_nil.email).to be_nil
    end

    it "returns nil values in #to_h" do
      expect(client_with_nil.to_h).to eq({ id: nil, full_name: nil, email: nil })
    end
  end
end
