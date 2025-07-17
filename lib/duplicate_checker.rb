# frozen_string_literal: true

class DuplicateChecker
  def initialize(clients)
    @clients = clients
  end

  # We may extend this in the future by allowing other fields to group by
  def find_duplicates
    @clients.group_by(&:email).select { |_, group| group.size > 1 }
  end
end
