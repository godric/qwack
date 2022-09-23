# frozen_string_literal: true

require_relative './spec_helper'
require_relative '../lib/qwack/base'
require_relative '../lib/qwack/meta'

describe Qwack::Meta do
  before do
    stub_class('DummyType') do
      extend Qwack::Base
    end
  end

  describe '#array_of' do
    before do
      stub_const('DummyArrayOf', Qwack::Meta.array_of(DummyType))
    end

    describe "#validation_errors" do
      it "behave like an array of allowed types" do
        expect(DummyArrayOf.validation_errors(''))
          .to eq([{ desc: "Is not an array", item: "", name: "DummyArrayOf", path: "root" }])
        expect(DummyArrayOf.validation_errors([]))
          .to be_empty

        expect(DummyType).to receive(:validation_errors)
          .with('1', 'root.0').once.and_return(['error1'])
        expect(DummyArrayOf.validation_errors(['1']))
          .to eq(['error1'])
      end
    end
  end
end