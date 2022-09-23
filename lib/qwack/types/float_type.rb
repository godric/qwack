# frozen_string_literal: true

require_relative '../base_type'

module Qwack
  class FloatType
    extend Qwack::BaseType

    add_validator ->(input) { 'Not a float' unless input.is_a?(::Float) }

    default_mock 0.0
  end
end
