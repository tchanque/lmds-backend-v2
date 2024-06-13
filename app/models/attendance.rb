class Attendance < ApplicationRecord
  belongs_to :attendee, class_name: 'User'
  belongs_to :event
  belongs_to :event_instrument

  validates :is_pending, inclusion: { in: [true, false] }
end
