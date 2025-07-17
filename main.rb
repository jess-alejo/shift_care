### ShiftCare Technical Challenge ###
#
# Launch this file from the command line with:
#   ruby main.rb
#
APP_ROOT = File.dirname(__FILE__)

$:.unshift(File.join(APP_ROOT, "lib"))
require "client_directory"

ClientDirectory.run!
