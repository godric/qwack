# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../../lib/qwack/types/date_type'

describe Qwack::DateType do
  describe "#validation_errors" do
    it "rejects nil" do
      expect(described_class.validation_errors(nil))
        .to eq([{ desc: "Not a date", item: nil, name: "Qwack::DateType", path: "root" }])
    end

    it "rejects integers" do
      expect(described_class.validation_errors(0))
        .to eq([{ desc: "Not a date", item: 0, name: "Qwack::DateType", path: "root" }])
    end

    it "allows a formated date" do
      expect(described_class.validation_errors('2022-01-01'))
        .to be_empty
    end

    it "allows a formated datetime" do
      expect(described_class.validation_errors('2022-01-01 01:01'))
        .to be_empty
    end

    it "allows a ISO860 date" do
      expect(described_class.validation_errors('2022-01-01T01:01Z'))
        .to be_empty
    end
  end

  describe "#mock" do
    it "returns a valid object" do
      expect(described_class.mock)
        .to eq('1990-01-01T00:00:00+00')
    end
  end
end