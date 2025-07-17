# frozen_string_literal: true

require_relative "../lib/display"

RSpec.describe Display do
  describe ".print_data" do
    context "when rows are empty" do
      it 'prints "No data"' do
        expect { described_class.print_data([]) }.to output("No data\n").to_stdout
      end
    end

    context "when rows contain one hash" do
      let(:data) { [{ id: 1, full_name: "Jane Smith", email: "jane.smith@example.com" }] }

      it "prints a header and one row" do
        expect do
          described_class.print_data(data)
        end.to output(<<~OUTPUT).to_stdout
          id | full_name  | email#{'                 '}
          ------------------------------------------------------------
          1  | Jane Smith | jane.smith@example.com
          ------------------------------------------------------------
        OUTPUT
      end
    end
  end
end
