# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../../lib/qwack/types/float_type'

describe Qwack::FloatType do
  describe "#validation_errors" do
    it "rejects nil" do
      expect(described_class.validation_errors(nil))
        .to eq([{ desc: "Not a float", item: nil, name: "Qwack::FloatType", path: "root" }])
    end

    it "rejects integers" do
      expect(described_class.validation_errors(0))
        .to eq([{ desc: "Not a float", item: 0, name: "Qwack::FloatType", path: "root" }])
    end

    it "rejects strings" do
      expect(described_class.validation_errors('0.0'))
        .to eq([{ desc: "Not a float", item: '0.0', name: "Qwack::FloatType", path: "root" }])
    end

    it "allows strings" do
      expect(described_class.validation_errors(0.0))
        .to be_empty
    end
  end

  describe "#mock" do
    it "returns a valid object" do
      expect(described_class.mock)
        .to eq(0.0)
    end
  end
end