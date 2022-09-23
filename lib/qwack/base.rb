# frozen_string_literal: true

require_relative './errors'

module Qwack
  module Base
    def validation_errors(input, path = 'root')
      raise NotImplementedError
    end

    def validate!(input, path = 'root')
      errors = validation_errors(input, path)
      raise Qwack::Errors::ValidationError, errors unless errors.empty?

      input
    end

    def mock(input)
      raise NotImplementedError
    end
  end
end
