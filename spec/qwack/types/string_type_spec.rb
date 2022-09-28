# frozen_string_literal: true

require 'spec_helper'
require 'qwack/types/string'

describe Qwack::Types::String do
  describe '#validation_errors' do
    it 'rejects nil' do
      expect(described_class.validation_errors(nil))
        .to eq([{ desc: 'Not a string', item: nil, name: 'Qwack::Types::String', path: 'root' }])
    end

    it 'rejects Symbols' do
      expect(described_class.validation_errors(:test))
        .to eq([{ desc: 'Not a string', item: :test, name: 'Qwack::Types::String', path: 'root' }])
    end

    it 'allows empty strings' do
      expect(described_class.validation_errors(''))
        .to be_empty
    end

    it 'allows strings' do
      expect(described_class.validation_errors('dummy'))
        .to be_empty
    end
  end

  describe '#mock' do
    it 'returns a default value' do
      expect(described_class.mock)
        .to eq('')
    end

    it 'returns a valid object' do
      expect(described_class.validation_errors(described_class.mock))
        .to be_empty
    end

    it 'return input if any' do
      expect(described_class.mock('dummy'))
        .to eq('dummy')
    end
  end
end
