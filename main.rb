# frozen_string_literal: true

### ShiftCare Technical Challenge ###
#
# Launch this file from the command line with:
#   ruby init.rb
#
APP_ROOT = File.dirname(__FILE__)
$:.unshift(File.join(APP_ROOT, "lib"))

require "data_loader"
require "client_search"
require "duplicate_checker"
require "display"

def print_usage
  puts "Usage:"
  puts "  ruby main.rb search <query>"
  puts "  ruby main.rb duplicates"
end

command, arg = ARGV

case command
when "search"
  if arg.nil?
    puts "Please provide a search term."
  else
    clients = DataLoader.load(source: "data/clients.json")
    results = ClientSearch.new(clients).search(arg)
    Display.print_search_results(results)
  end
when "duplicates"
  clients = DataLoader.load(source: "data/clients.json")
  duplicates = DuplicateChecker.new(clients).find_duplicates
  Display.print_duplicates(duplicates)
else
  print_usage
end
