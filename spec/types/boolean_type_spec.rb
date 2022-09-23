# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../../lib/qwack/types/boolean_type'

describe Qwack::BooleanType do
  describe "#validation_errors" do
    it "rejects nil" do
      expect(described_class.validation_errors(nil))
        .to eq([{ desc: "Not a boolean", item: nil, name: "Qwack::BooleanType", path: "root" }])
    end

    it "rejects string" do
      expect(described_class.validation_errors('true'))
        .to eq([{ desc: "Not a boolean", item: 'true', name: "Qwack::BooleanType", path: "root" }])
    end

    it "allows true" do
      expect(described_class.validation_errors(true))
        .to be_empty
    end

    it "allows false" do
      expect(described_class.validation_errors(false))
        .to be_empty
    end
  end

  describe "#mock" do
    it "returns a valid object" do
      expect(described_class.mock)
        .to eq(false)
    end
  end

  describe "#validate!" do
    it "returns a the input in case of an error" do
      expect(described_class.validate!(true))
        .to eq(true)
    end
  end
end