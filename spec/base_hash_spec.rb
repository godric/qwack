# frozen_string_literal: true

require_relative './spec_helper'
require_relative '../lib/qwack/base'
require_relative '../lib/qwack/base_hash'

describe Qwack::BaseHash do
  before do
    stub_class('DummyType') do
      extend Qwack::Base
    end
  end

  describe 'without attributes' do
    before do
      stub_class('DummyEmptyHashType') do
        extend Qwack::BaseHash
      end
    end

    describe "#validation_errors" do
      it "accepts an empty hash" do
        expect(DummyEmptyHashType.validation_errors({}))
          .to be_empty
      end

      it "rejects a non-hash" do
        expect(DummyEmptyHashType.validation_errors(''))
          .to eq([{ desc: "Is not a Hash", item: "", name: "DummyEmptyHashType", path: "root" }])
      end
    end
  end

  describe 'with a simple attribute' do
    before do
      stub_class('DummySimpleHashType') do
        extend Qwack::BaseHash
        add_attribute 'key', type: DummyType
      end
    end

    describe "#validation_errors" do
      it "rejects a missing non optional attribute" do
        expect(DummySimpleHashType.validation_errors({}))
          .to eq([{ desc: "Missing non-optional key", item: "key", name: "DummySimpleHashType", path: "root" }])
      end

      it "rejects a null non nullable attribute" do
        expect(DummySimpleHashType.validation_errors({"key" => nil}))
          .to eq([{ desc: "Key cannot be null", item: "key", name: "DummySimpleHashType", path: "root" }])
      end

      it "rejects a extra unspecified attribute" do
        expect(DummyType).to receive(:validation_errors)
         .with(1, 'root.key').once.and_return([])
        expect(DummySimpleHashType.validation_errors({"key" => 1, "extra" => nil}))
          .to eq([{ desc: "Extraneous keys", item: "extra", name: "DummySimpleHashType", path: "root" }])
      end

      it "forwards validation of Hash items to the attribute type" do
        expect(DummyType).to receive(:validation_errors)
         .with(1, 'root.key').once.and_return([])

        expect(DummySimpleHashType.validation_errors({ "key" => 1 }))
          .to be_empty
      end

      it "returns validation errors of Hash items from the attribute type" do
        expect(DummyType).to receive(:validation_errors)
          .with(1, 'root.key').once.and_return(['error1', 'error2'])
        expect(DummySimpleHashType.validation_errors({"key" => 1}))
          .to eq(['error1', 'error2'])
      end
    end

    describe "#mock" do
      it "forwards mocking to the attribute type" do
        expect(DummyType).to receive(:mock)
          .with(nil).once.and_return(1)
        expect(DummySimpleHashType.mock())
          .to eq({ "key" => 1 })
      end
    end
  end

  describe 'with an optional attribute' do
    before do
      stub_class('DummyOptionalHashType') do
        extend Qwack::BaseHash
        add_attribute 'key', type: DummyType, optional: true
      end
    end

    describe "#validation_errors" do
      it "accept a missing optional attribute" do
        expect(DummyOptionalHashType.validation_errors({}))
          .to be_empty
      end
    end
  end

  describe 'with a nullable attribute' do
    before do
      stub_class('DummyNullableHashType') do
        extend Qwack::BaseHash
        add_attribute 'key', type: DummyType, null: true
      end
    end

    describe "#validation_errors" do
      it "accept a missing optional attribute" do
        expect(DummyNullableHashType.validation_errors({"key" => nil}))
          .to be_empty
      end
    end
  end
end