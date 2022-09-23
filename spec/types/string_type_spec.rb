# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../../lib/qwack/types/string_type'

describe Qwack::StringType do
  describe "#validation_errors" do
    it "rejects nil" do
      expect(described_class.validation_errors(nil))
        .to eq([{ desc: "Not a string", item: nil, name: "Qwack::StringType", path: "root" }])
    end

    it "rejects Symbols" do
      expect(described_class.validation_errors(:test))
        .to eq([{ desc: "Not a string", item: :test, name: "Qwack::StringType", path: "root" }])
    end

    it "allows empty strings" do
      expect(described_class.validation_errors(''))
        .to be_empty
    end

    it "allows strings" do
      expect(described_class.validation_errors('dummy'))
        .to be_empty
    end
  end

  describe "#mock" do
    it "returns a valid object" do
      expect(described_class.mock)
        .to eq('')
    end
  end
end