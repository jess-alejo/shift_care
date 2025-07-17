# frozen_string_literal: true

class Display
  @@screen_width = 60

  class << self
    def screen_width=(screen_width = 60)
      @@screen_width = screen_width
    end

    def print_header
      puts "\n"
      puts "-" * @@screen_width
      puts APP_TITLE.center(@@screen_width)
      puts "-" * @@screen_width
    end

    def print_usage
      print_header

      puts <<~USAGE
        Usage: ruby main.rb [command] [options]

        Commands:
          search <query>           Search clients by name
          duplicates               Find clients with duplicate emails

        Options:
          --screen-width WIDTH     Set max screen width for display
      USAGE

      puts "\n\n"
    end

    def print_search_results(clients, arg)
      print_header

      if clients.empty?
        puts "No clients matched your query."
      else
        print_data(clients.map(&:to_h))
      end

      puts "\nSearch results for: #{arg}\n\n"
    end

    def print_duplicates(duplicates)
      print_header

      if duplicates.empty?
        puts "No duplicate clients found."
      else
        duplicates.each do |email, clients|
          puts "\nEmail: #{email}"
          print_line_separator
          print_data(
            clients.map { |client| client.to_h.slice(:id, :full_name) },
            header: "off"
          )
        end
        print_line_separator(" ")
      end

      puts "\nDuplicate Clients by Email\n\n"
    end

    def print_data(rows = [], options = {})
      return puts "No data" if rows.empty?

      headers = rows.first.keys

      # Determine max width per column (header vs. content)
      col_widths = headers.map do |key|
        [key.to_s.length, *rows.map { |row| row[key].to_s.length }].max
      end

      format_str = col_widths.map { |w| "%-#{w}s" }.join(" | ")

      # Print header
      unless options[:header].to_s == "off"
        puts format_str % headers.map(&:to_s)
        puts "-" * @@screen_width
      end

      # Print each row
      rows.each do |row|
        puts format_str % headers.map { |key| row[key].to_s }
      end

      # table footer
      puts "-" * @@screen_width
    end

    def print_line_separator(separator = "-")
      puts separator * @@screen_width
    end
  end
end
