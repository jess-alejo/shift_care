# frozen_string_literal: true

class ClientSearch
  def initialize(clients)
    @clients = clients
  end

  def search(query)
    @clients.select do |client|
      client.full_name.downcase.include?(query.downcase)
    end
  end
end
