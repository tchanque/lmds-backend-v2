require 'rails_helper'

RSpec.describe Instrument, type: :model do

  subject {
    described_class.new(
      name: "Guitare",
    )
  }

  describe "validations" do 
    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:name]).to include("can't be blank")
    end

    it "is not valid with an invalid instrument name" do
      subject.name = "Invalid instrument name"
      expect(subject).to_not be_valid
      expect(subject.errors[:name]).to include("is not included in the list")
    end
  end

end
