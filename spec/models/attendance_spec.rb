require 'rails_helper'

RSpec.describe Attendance, type: :model do
  subject { build(:attendance) }

  context 'validations' do
    it { should validate_inclusion_of(:is_pending).in_array([true, false]) }
  end

  context 'associations' do
    it { should belong_to(:attendee).class_name('User') }
    it { should belong_to(:event) }
    it { should belong_to(:event_instrument) }
  end

  context 'creation' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end
  end
end
