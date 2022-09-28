# frozen_string_literal: true

require_relative './base_array'

module Qwack
  # Shorthand for defining Array types
  class Meta
    def self.array_of(type)
      Class.new do
        extend Qwack::Base
        extend Qwack::BaseArray
        allow_types(type)
      end
    end
  end
end
