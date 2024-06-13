class Skill < ApplicationRecord
  belongs_to :musician, class_name: 'User'
  belongs_to :instrument

  LEVEL = [0, 1, 2, 3, 4, 5]

  validates :musician, presence: true
  validates :instrument, presence: true
  validates :level, presence: true, inclusion: { in: LEVEL }
end
