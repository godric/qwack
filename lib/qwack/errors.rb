# frozen_string_literal: true

require 'pp'

module Qwack
  module Errors
    class ValidationError < StandardError
      attr_reader :validation_errors

      def initialize(validation_errors = [])
        @validation_errors = validation_errors
        super("Found the following errors:\n #{validation_errors.pretty_inspect}")
      end
    end
  end
end
