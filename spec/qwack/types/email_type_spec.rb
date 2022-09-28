# frozen_string_literal: true

require 'spec_helper'
require 'qwack/types/email'

describe Qwack::Types::Email do
  describe '#validation_errors' do
    it 'rejects nil' do
      expect(described_class.validation_errors(nil))
        .to eq([{ desc: 'Not an email', item: nil, name: 'Qwack::Types::Email', path: 'root' }])
    end

    it 'rejects malformed email' do
      expect(described_class.validation_errors('test@host@test'))
        .to eq([{ desc: 'Not an email', item: 'test@host@test', name: 'Qwack::Types::Email', path: 'root' }])
    end

    it 'allows an email' do
      expect(described_class.validation_errors('test@host'))
        .to be_empty
    end
  end

  describe '#mock' do
    it 'returns a default value' do
      expect(described_class.mock)
        .to eq('name@domain')
    end

    it 'returns a valid object' do
      expect(described_class.validation_errors(described_class.mock))
        .to be_empty
    end

    it 'return input if any' do
      expect(described_class.mock('dummy@localhost'))
        .to eq('dummy@localhost')
    end
  end
end
