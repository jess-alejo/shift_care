# frozen_string_literal: true

require_relative "../client"

module Builders
  class Base
    def initialize(filepath)
      @filepath = filepath
    end

    def build
      raise NotImplementedError, "You must implement the build method in a #{self.class.name}"
    end
  end
end
