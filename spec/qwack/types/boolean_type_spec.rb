# frozen_string_literal: true

require 'spec_helper'
require 'qwack/types/boolean'

describe Qwack::Types::Boolean do
  describe '#validation_errors' do
    it 'rejects nil' do
      expect(described_class.validation_errors(nil))
        .to eq([{ desc: 'Not a boolean', item: nil, name: 'Qwack::Types::Boolean', path: 'root' }])
    end

    it 'rejects string' do
      expect(described_class.validation_errors('true'))
        .to eq([{ desc: 'Not a boolean', item: 'true', name: 'Qwack::Types::Boolean', path: 'root' }])
    end

    it 'allows true' do
      expect(described_class.validation_errors(true))
        .to be_empty
    end

    it 'allows false' do
      expect(described_class.validation_errors(false))
        .to be_empty
    end
  end

  # describe '#validate!' do
  #   it 'returns a the input in case of an error' do
  #     expect(described_class.validate!(true))
  #       .to eq(true)
  #   end
  # end

  describe '#mock' do
    it 'returns a default value' do
      expect(described_class.mock)
        .to be(false)
    end

    it 'returns a valid object' do
      expect(described_class.validation_errors(described_class.mock))
        .to be_empty
    end

    it 'return input if any' do
      expect(described_class.mock(true))
        .to be(true)
    end
  end
end
