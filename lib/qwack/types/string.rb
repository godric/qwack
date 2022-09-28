# frozen_string_literal: true

require_relative '../base_type'

module Qwack
  module Types
    class String
      extend Qwack::BaseType

      add_validator ->(input) { 'Not a string' unless input.is_a?(::String) }

      default_mock ''
    end
  end
end
