# frozen_string_literal: true

require 'spec_helper'
require 'qwack/types/float'

describe Qwack::Types::Float do
  describe '#validation_errors' do
    it 'rejects nil' do
      expect(described_class.validation_errors(nil))
        .to eq([{ desc: 'Not a float', item: nil, name: 'Qwack::Types::Float', path: 'root' }])
    end

    it 'rejects integers' do
      expect(described_class.validation_errors(0))
        .to eq([{ desc: 'Not a float', item: 0, name: 'Qwack::Types::Float', path: 'root' }])
    end

    it 'rejects strings' do
      expect(described_class.validation_errors('0.0'))
        .to eq([{ desc: 'Not a float', item: '0.0', name: 'Qwack::Types::Float', path: 'root' }])
    end

    it 'allows strings' do
      expect(described_class.validation_errors(0.0))
        .to be_empty
    end
  end

  describe '#mock' do
    it 'returns a default value' do
      expect(described_class.mock)
        .to eq(0.0)
    end

    it 'returns a valid object' do
      expect(described_class.validation_errors(described_class.mock))
        .to be_empty
    end

    it 'return input if any' do
      expect(described_class.mock(0.42))
        .to eq(0.42)
    end
  end
end
