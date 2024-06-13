require 'rails_helper'

RSpec.describe Publication, type: :model do
  let(:user) { create(:user) }

  subject {
    described_class.new(
      title: "Sample Title",
      description: "Sample description",
      to_display: true,
      creator: user
    )
  }

  context 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a title' do
      subject.title = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:title]).to include("can't be blank")
    end

    it 'is not valid without a description' do
      subject.description = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:description]).to include("can't be blank")
    end

    it 'is not valid without to_display' do
      subject.to_display = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:to_display]).to include("can't be blank")
    end
  end

  context 'associations' do
    it { should belong_to(:creator).class_name('User') }
  end
end
