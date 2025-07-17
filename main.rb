# frozen_string_literal: true

### ShiftCare Technical Challenge ###
#
# Launch this file from the command line with:
#   ruby main.rb search <query>
#   ruby main.rb duplicates
#
APP_ROOT = File.dirname(__FILE__)
$LOAD_PATH.unshift(File.join(APP_ROOT, "lib"))

require "optparse"
options = {}

require "data_loader"
require "client_search"
require "duplicate_checker"
require "display"

Display.app_title = "ShiftCare: Client Directory"

command, arg = ARGV

OptionParser.new do |opts|
  opts.banner = "Usage: ruby main.rb [options]"

  opts.on("--screen-width WIDTH", Integer, "Set screen width") do |width|
    options[:screen_width] = width
  end
end.parse!

Display.screen_width = options[:screen_width] || 60

case command
when "search"
  if arg.nil?
    puts "Please provide a search term."
  else
    clients = DataLoader.load(source: "data/clients.json")
    results = ClientSearch.new(clients).search(arg)
    Display.print_search_results(results, arg)
  end
when "duplicates"
  clients = DataLoader.load(source: "data/clients.json")
  duplicates = DuplicateChecker.new(clients).find_duplicates
  Display.print_duplicates(duplicates)
else
  Display.print_usage
end
