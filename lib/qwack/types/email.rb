# frozen_string_literal: true

require_relative '../base_type'

module Qwack
  module Types
    class Email
      extend Qwack::BaseType

      add_validator ->(input) { 'Not an email' unless input&.match?(URI::MailTo::EMAIL_REGEXP) }

      default_mock 'name@domain'
    end
  end
end
