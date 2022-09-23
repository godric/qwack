# frozen_string_literal: true

require_relative './base'

module Qwack
  module BaseHash
    include Qwack::Base

    def attributes
      ancestors.reverse.each_with_object({}) do |ancestor, obj|
        obj.merge!(ancestor.own_attributes) if ancestor.respond_to?(:own_attributes)
      end
    end

    def own_attributes
      @own_attributes ||= {}
    end

    def validation_errors(input, path = 'root')
      return [{ path: path, name: name, desc: 'Is not a Hash', item: input }] \
        unless input.is_a?(::Hash)

      all_attributes = attributes
      (all_attributes.keys + input.keys).uniq.each_with_object([]) do |key, errors|
        if !all_attributes.key?(key)
          errors << { path: path, name: name, desc: 'Extraneous keys', item: key }
        elsif !input.key?(key)
          errors << { path: path, name: name, desc: 'Missing non-optional key', item: key } \
            if all_attributes[key][:optional] != true
        elsif input[key].nil?
          errors << { path: path, name: name, desc: 'Key cannot be null', item: key } \
            if all_attributes[key][:null] != true
        else
          errors.append(*all_attributes[key][:type].validation_errors(input[key], "#{path}.#{key}"))
        end
      end
    end

    def mock(input = nil)
      attributes.each_with_object({}) do |(key, conf), obj|
        obj[key] = conf[:type].mock(input&.fetch(key, nil) || conf[:mock])
      end
    end

    private

    def add_attribute(key, type:, **args)
      own_attributes[key] = { type: type, **args }
    end
  end
end
