# frozen_string_literal: true

require 'pry'
require_relative './base'

module Qwack
  # Base module for user defined types
  module BaseType
    include Qwack::Base

    def validators
      ancestors.reverse.each_with_object([]) do |ancestor, obj|
        obj.append(*ancestor.own_validators) \
          if ancestor.respond_to?(:own_validators)
      end
    end

    def own_validators
      @own_validators = [] unless instance_variable_defined?('@own_validators')

      @own_validators
    end

    def own_default_mock
      @own_default_mock = nil unless instance_variable_defined?('@own_default_mock')

      @own_default_mock
    end

    def validation_errors(input, path = 'root')
      validators.each_with_object([]) do |validator, errors|
        error = validator.call(input)
        errors << { path: path, name: name, desc: error, item: input } \
          unless error.nil?
      end
    end

    def mock(input = nil)
      input || own_default_mock
    end

    private

    def add_validator(validator)
      own_validators.push(validator)
    end

    def default_mock(value)
      @own_default_mock = value
    end
  end
end
