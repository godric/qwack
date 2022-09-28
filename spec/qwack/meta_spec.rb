# frozen_string_literal: true

require 'spec_helper'
require 'qwack/base'
require 'qwack/meta'

describe Qwack::Meta do
  before do
    stub_class('DummyType') do
      extend Qwack::Base
    end
  end

  describe '#array_of' do
    before do
      stub_const('DummyArrayOf', described_class.array_of(DummyType))
    end

    describe '#validation_errors' do
      it 'rejects non arrays' do
        expect(DummyArrayOf.validation_errors(''))
          .to eq([{ desc: 'Is not an array', item: '', name: 'DummyArrayOf', path: 'root' }])
      end

      it 'allows an empty array' do
        expect(DummyArrayOf.validation_errors([]))
          .to be_empty
      end

      it 'forward validation to the allowed type' do
        allow(DummyType).to receive(:validation_errors)
          .with('1', 'root.0').once.and_return(['error1'])
        expect(DummyArrayOf.validation_errors(['1']))
          .to eq(['error1'])
      end
    end
  end
end
