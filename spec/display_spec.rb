# frozen_string_literal: true

require_relative "../lib/display"

RSpec.describe Display do
  describe ".print_data" do
    context "when rows are empty" do
      it 'prints "No data"' do
        expect { described_class.print_data([]) }.to output("No data\n").to_stdout
      end
    end

    context "when rows contain at least one hash" do
      let(:data) { [{ id: 1, full_name: "Jane Smith", email: "jane.smith@example.com" }] }

      it "prints a header and a row" do
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

    it "prints data without headers when header is off" do
      data = [{ id: 1, full_name: "Jane Smith" }]
      expect do
        described_class.print_data(data, header: "off")
      end.to output(<<~OUTPUT).to_stdout
        1  | Jane Smith
        ------------------------------------------------------------
      OUTPUT
    end

    it "adjusts column widths based on content length" do
      data = [
        { id: 1, full_name: "Jane", email: "short@example.com" },
        { id: 2, full_name: "Very Long Full Name", email: "longer.email@exampledomain.com" }
      ]

      expect do
        described_class.print_data(data)
      end.to output(/Very Long Full Name/).to_stdout
    end
  end

  describe ".print_search_results" do
    it "prints search results header and data" do
      clients = [double(to_h: { id: 1, full_name: "Jane", email: "jane@example.com" })]

      expect do
        described_class.print_search_results(clients, "Jane")
      end.to output(/Search results for: Jane/).to_stdout
    end

    it "prints message when search yields no results" do
      expect do
        described_class.print_search_results([], "Bob")
      end.to output(/No clients matched your query/).to_stdout
    end
  end

  describe ".print_duplicates" do
    it "prints duplicates grouped by email" do
      clients = [
        double(to_h: { id: 1, full_name: "Jane", email: "jane@example.com" }),
        double(to_h: { id: 2, full_name: "Janet", email: "jane@example.com" })
      ]

      duplicates = { "jane@example.com" => clients }

      expect do
        described_class.print_duplicates(duplicates)
      end.to output(/Email: jane@example.com/).to_stdout
    end

    it "prints message when no duplicates found" do
      expect do
        described_class.print_duplicates({})
      end.to output(/No duplicate clients found/).to_stdout
    end
  end
end
