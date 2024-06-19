# spec/models/event_spec.rb
require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:creator) { create(:user) }
  
  subject {
    described_class.new(
      creator: creator,
      category: "Concert",
      title: "Concert de Folk",
      start_date: Date.today + 1.day,
      end_date: Date.today + 2.days,
      location: "Paris",
      price: 50
    )
  }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a creator" do
      subject.creator = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:creator]).to include("must exist")
    end

    it "is not valid without a category" do
      subject.category = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:category]).to include("can't be blank")
    end

    it "is not valid without a title" do
      subject.title = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:title]).to include("can't be blank")
    end

    it "is not valid with an invalid category" do
      subject.category = "Invalid Category"
      expect(subject).to_not be_valid
      expect(subject.errors[:category]).to include("is not included in the list")
    end

    it "is not valid without a start_date" do
      subject.start_date = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:date]).to include("must exist.")
    end

    it "is not valid with a past start_date" do
      subject.start_date = Date.yesterday
      expect(subject).to_not be_valid
      expect(subject.errors[:date]).to include("can't be past.")
    end

    it "is not valid without an end_date" do
      subject.end_date = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:date]).to include("must exist.")
    end

    it "is not valid with an end_date before start_date" do
      subject.end_date = subject.start_date - 1.day
      expect(subject).to_not be_valid
      expect(subject.errors[:date]).to include("can't be before start date")
    end

    it "is not valid without a location" do
      subject.location = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:location]).to include("can't be blank")
    end

    it "is not valid with a negative price" do
      subject.price = -1
      expect(subject).to_not be_valid
      expect(subject.errors[:price]).to include("must be greater than or equal to 0")
    end
  end
end

