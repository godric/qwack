# frozen_string_literal: true

require_relative '../base_type'

module Qwack
  class IntegerType
    extend Qwack::BaseType

    add_validator ->(input) { 'Not an integer' unless input.is_a?(::Integer) }

    default_mock 0
  end
end
