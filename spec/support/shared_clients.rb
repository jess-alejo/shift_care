# frozen_string_literal: true

require_relative "../../lib/client"

RSpec.shared_context "with sample clients" do
  let(:clients) do
    [
      Client.new(id: 1, full_name: "Alice Santos", email: "alice.santos@example.com"),
      Client.new(id: 2, full_name: "Bob Cruz", email: "bob.cruz@example.com"),
      Client.new(id: 3, full_name: "Catrina Sandoval", email: "cat.sandoval@example.com"),
      Client.new(id: 4, full_name: "Dione Cruz", email: "bob.cruz@example.com")
    ]
  end
end
