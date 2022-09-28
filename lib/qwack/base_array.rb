# frozen_string_literal: true

require_relative './base'

module Qwack
  # Base module for user defined arrays
  module BaseArray
    include Qwack::Base

    def allowed_types
      ancestors.reverse.each_with_object([]) do |ancestor, obj|
        obj.append(*ancestor.own_allowed_types) \
          if ancestor.respond_to?(:own_allowed_types)
      end
    end

    def own_allowed_types
      @own_allowed_types ||= []
    end

    def validation_errors(input, path = 'root')
      return [{ path: path, name: name, desc: 'Is not an array', item: input }] \
        unless input.is_a?(::Array)

      all_allowed_types = allowed_types
      input.each_with_object([]).with_index do |(item, errors), index|
        all_allowed_types.each do |type|
          errors.append(*type.validation_errors(item, "#{path}.#{index}"))
        end
      end
    end

    def mock(input = nil)
      input || []
    end

    private

    def allow_types(types)
      own_allowed_types.append(*types)
    end
  end
end
