# frozen_string_literal: true

require_relative '../base_type'

module Qwack
  class EmailType
    extend Qwack::BaseType

    add_validator -> (input) { 'Not an email' unless input&.match?(URI::MailTo::EMAIL_REGEXP) }

    default_mock 'name@domain'
  end
end
