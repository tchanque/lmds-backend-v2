require 'rails_helper'

RSpec.describe EventInstrument, type: :model do
  # Association tests
  it { should belong_to(:event) }
  it { should belong_to(:instrument) }

  # Validation tests
  it { should validate_presence_of(:total_spots) }
  it { should validate_presence_of(:available_spots) }
  it { should validate_presence_of(:level) }
  it { should validate_inclusion_of(:level).in_array([0, 1, 2, 3, 4, 5]) }
end
