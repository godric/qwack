# frozen_string_literal: true

require 'spec_helper'
require 'qwack/base'
require 'qwack/base_enum'

describe Qwack::BaseEnum do
  before do
    stub_class('DummyType') do
      extend Qwack::Base
    end
  end

  describe 'without attributes' do
    before do
      stub_class('DummyEnumType') do
        extend Qwack::BaseEnum # rubocop:disable RSpec/DescribedClass
        allow_values %w[a b]
      end
    end

    describe '#validation_errors' do
      it 'accepts a allowed value' do
        expect(DummyEnumType.validation_errors('b'))
          .to be_empty
      end

      it 'rejects a unallowed value' do
        expect(DummyEnumType.validation_errors('c'))
          .to eq([{ desc: 'Is not an allowed value', item: 'c', name: 'DummyEnumType', path: 'root' }])
      end
    end

    describe '#mock' do
      it 'mocks with the first allowed value' do
        expect(DummyEnumType.mock)
          .to eq('a')
      end
    end
  end
end
