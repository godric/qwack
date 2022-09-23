# frozen_string_literal: true

require 'date'
require_relative './base_type'

module Qwack
  class BooleanType
    extend Qwack::BaseType
    add_validator ->(input) { 'Not a Boolean' unless [true, false].include?(input) }
    default_mock false
  end

  class StringType
    extend Qwack::BaseType
    add_validator ->(input) { 'Not a String' unless input.is_a?(::String) }
    default_mock false
  end

  class IntegerType
    extend Qwack::BaseType
    add_validator ->(input) { 'Not an Integer' unless input.is_a?(::Integer) }
    default_mock 0
  end

  class FloatType
    extend Qwack::BaseType
    add_validator ->(input) { 'Not an Float' unless input.is_a?(::Float) }
    default_mock 0.0
  end

  class DateType
    extend Qwack::BaseType

    add_validator lambda { |input|
      begin
        DateTime.parse(input)
        nil
      rescue StandardError => e
        binding.pry
        'Not a Date'
      end
    }

    default_mock '1990-01-01T00:00:00+00'
  end
end
