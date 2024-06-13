# spec/models/skill_spec.rb

require 'rails_helper'

RSpec.describe Skill, type: :model do
  # Définir des objets de test pour User et Instrument
  let(:user) { create(:user) }
  let(:instrument) { Instrument.create!(name: "Guitare") }

  # Sujet de test
  subject { described_class.new(musician: user, instrument: instrument, level: 3) }

  # Tests de validation
  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a musician' do
      subject.musician = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:musician]).to include("can't be blank")
    end

    it 'is not valid without an instrument' do
      subject.instrument = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:instrument]).to include("can't be blank")
    end

    it 'is not valid without a level' do
      subject.level = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:level]).to include("can't be blank")
    end

    it 'is not valid with a level not in the predefined list' do
      subject.level = 6
      expect(subject).not_to be_valid
      expect(subject.errors[:level]).to include("is not included in the list")
    end
  end

  # Tests d'association
  describe 'associations' do
    it { should belong_to(:musician).class_name('User') }
    it { should belong_to(:instrument) }
  end
end
