# frozen_string_literal: true

require 'spec_helper'
require 'qwack/types/date'

describe Qwack::Types::Date do
  describe '#validation_errors' do
    it 'rejects nil' do
      expect(described_class.validation_errors(nil))
        .to eq([{ desc: 'Not a date', item: nil, name: 'Qwack::Types::Date', path: 'root' }])
    end

    it 'rejects integers' do
      expect(described_class.validation_errors(0))
        .to eq([{ desc: 'Not a date', item: 0, name: 'Qwack::Types::Date', path: 'root' }])
    end

    it 'allows a formated date' do
      expect(described_class.validation_errors('2022-01-01'))
        .to be_empty
    end

    it 'allows a formated datetime' do
      expect(described_class.validation_errors('2022-01-01 01:01'))
        .to be_empty
    end

    it 'allows a ISO860 date' do
      expect(described_class.validation_errors('2022-01-01T01:01Z'))
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
        .to eq('1990-01-01T00:00:00+00')
    end

    it 'returns a valid object' do
      expect(described_class.validation_errors(described_class.mock))
        .to be_empty
    end

    it 'return input if any' do
      expect(described_class.mock('2022-01-01'))
        .to eq('2022-01-01')
    end
  end
end
