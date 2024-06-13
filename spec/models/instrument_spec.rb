# spec/models/instrument_spec.rb
require 'rails_helper'

RSpec.describe Instrument, type: :model do
  subject {
    described_class.new(
      name: "Guitare"
    )
  }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:name]).to include("can't be blank")
    end

    it "is not valid with a name not in the list of allowed instruments" do
      subject.name = "Violon"
      expect(subject).to_not be_valid
      expect(subject.errors[:name]).to include("is not included in the list")
    end

    it "is valid with a name in the list of allowed instruments" do
      subject.name = "Piano"
      expect(subject).to be_valid
    end

    it "is not valid with a duplicate name" do
      described_class.create!(name: "Guitare")
      new_instrument = described_class.new(name: "Guitare")
      expect(new_instrument).to_not be_valid
      expect(new_instrument.errors[:name]).to include("has already been taken")
    end
  end
end
