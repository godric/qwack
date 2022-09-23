# frozen_string_literal: true

require 'date'
require_relative '../base_type'

module Qwack
  class DateType
    extend Qwack::BaseType

    add_validator lambda { |input|
      begin
        DateTime.parse(input)
        nil
      rescue StandardError => e
        'Not a date'
      end
    }

    default_mock '1990-01-01T00:00:00+00'
  end
end
