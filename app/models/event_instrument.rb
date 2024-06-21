class EventInstrument < ApplicationRecord
  belongs_to :event, class_name: 'Event'
  belongs_to :instrument, class_name: 'Instrument'

  has_many :attendances, dependent: :destroy

  LEVEL = [0, 1, 2, 3, 4, 5]

  validates :total_spots, :available_spots, presence: true
  validates :level, presence: true#, inclusion: { in: LEVEL }
end
