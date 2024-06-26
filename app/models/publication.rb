class Publication < ApplicationRecord

  has_one_attached :publication_picture
  belongs_to :creator, class_name: 'User'
  
  validates :title, presence: true
  validates :description, presence: true
  # validates :to_display, presence: true, inclusion: { in: [true, false] }
end
