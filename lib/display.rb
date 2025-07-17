# frozen_string_literal: true

class Display
  def self.print_search_results(clients)
    puts "\nSearch Results:"

    if clients.empty?
      puts 'No clients matched your query.'
    else
      clients.each do |client|
        puts "- #{[client.id, client.full_name, client.email].join("\t")}"
      end
    end
  end

  def self.print_duplicates(duplicates)
    puts "\nDuplicate Clients by Email:"

    if duplicates.empty?
      puts 'No duplicate clients found.'
    else
      duplicates.each do |email, clients|
        puts "Email: #{email}"
        clients.each do |client|
          puts "\t- #{[client.id, client.full_name].join("\t")}"
        end
      end
    end
  end
end
