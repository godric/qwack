# frozen_string_literal: true

require_relative '../base'
require_relative '../base_type'

module Qwack
  module Types
    class Boolean
      extend Qwack::BaseType

      add_validator ->(input) { 'Not a boolean' unless [true, false].include?(input) }

      default_mock false
    end
  end
end
