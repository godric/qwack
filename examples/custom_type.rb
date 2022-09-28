# frozen_string_literal: true

require 'pp'
require 'qwack'

# A field containing an UUID
class UUIDType
  extend Qwack::BaseType
  REGEXP = /[0-9a-f]{0}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/

  add_validator ->(input) { 'Not an UUID' unless input.match?(REGEXP) }

  default_mock '00000000-0000-0000-0000-000000000000'
end

pp(UUIDType.mock)
# Prints:
# "00000000-0000-0000-0000-000000000000"

UUIDType.validate!('123e4567-e89b-12d3-a456-426614174000')
# No exception, returns the input

UUIDType.validate!('abcdefgh')
# Raises exception:
# Found the following errors: (Qwack::Errors::ValidationError)
# [{:path=>"root", :name=>"UUIDType", :desc=>"Not an UUID", :item=>"abcdefgh"}]
