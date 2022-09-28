# frozen_string_literal: true

require_relative './base'

module Qwack
  # Base module for user defined enums
  module BaseEnum
    include Qwack::Base

    def allowed_values
      ancestors.reverse.each_with_object([]) do |ancestor, obj|
        obj.append(*ancestor.own_allowed_values) \
          if ancestor.respond_to?(:own_allowed_values)
      end
    end

    def own_allowed_values
      @own_allowed_values ||= []
    end

    def validation_errors(input, path = 'root')
      return [{ path: path, name: name, desc: 'Is not an allowed value', item: input }] \
        unless allowed_values.include?(input)

      []
    end

    def mock(input = nil)
      input || own_allowed_values&.first
    end

    private

    def allow_values(values)
      own_allowed_values.append(*values)
    end
  end
end
