# frozen_string_literal: true

require 'spec_helper'
require 'qwack/base'
require 'qwack/base_array'

describe Qwack::BaseArray do
  before do
    stub_class('DummyType') do
      extend Qwack::Base
    end
  end

  describe 'with a single allowed_type' do
    before do
      stub_class('DummyArrayType') do
        extend Qwack::BaseArray # rubocop:disable RSpec/DescribedClass
        allow_types [DummyType]
      end
    end

    describe '#validation_errors' do
      it 'rejects a non-array' do
        expect(DummyArrayType.validation_errors(''))
          .to eq([
                   { desc: 'Is not an array', item: '',
                     name: 'DummyArrayType', path: 'root' }
                 ])
      end

      it 'forwards validation of array items to the allowed type' do
        allow(DummyType).to receive(:validation_errors)
          .with(1, 'root.0').once.and_return([])
        allow(DummyType).to receive(:validation_errors)
          .with(2, 'root.1').once.and_return([])
        expect(DummyArrayType.validation_errors([1, 2])).to be_empty
      end

      it 'returns validation errors of array items from the allowed type' do
        allow(DummyType).to receive(:validation_errors)
          .and_return(%w[dummy_error1 dummy_error2])
        expect(DummyArrayType.validation_errors([1]))
          .to eq(%w[dummy_error1 dummy_error2])
      end
    end

    describe '#mock' do
      it 'returns a empty array' do
        expect(DummyArrayType.mock)
          .to eq([])
      end
    end
  end
end
