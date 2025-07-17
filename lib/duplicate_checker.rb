# frozen_string_literal: true

class DuplicateChecker
  def initialize(clients)
    @clients = clients
  end

  def find_duplicates
    @clients.group_by(&:email).select { |_, group| group.size > 1 }
  end
end
