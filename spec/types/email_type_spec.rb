# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../../lib/qwack/types/email_type'

describe Qwack::EmailType do
  describe "#validation_errors" do
    it "rejects nil" do
      expect(described_class.validation_errors(nil))
        .to eq([{ desc: "Not an email", item: nil, name: "Qwack::EmailType", path: "root" }])
    end

    it "rejects malformed email" do
      expect(described_class.validation_errors('test@host@test'))
        .to eq([{ desc: "Not an email", item: 'test@host@test', name: "Qwack::EmailType", path: "root" }])
    end

    it "allows an email" do
      expect(described_class.validation_errors('test@host'))
        .to be_empty
    end
  end

  describe "#mock" do
    it "returns a valid object" do
      mock = described_class.mock

      expect(mock)
        .to eq('name@domain')
      expect(described_class.validation_errors(mock))
        .to be_empty
    end
  end
end