class Publication < ApplicationRecord

  has_one_attached :publication_picture
  belongs_to :creator, class_name: 'User'
  
  validates :title, presence: true
  validates :description, presence: true
  # validates :to_display, presence: true, inclusion: { in: [true, false] }


  def publication_picture_url
    if publication_picture.attached?
      Rails.application.routes.url_helpers.rails_blob_path(publication_picture, only_path: true)
    else
      nil
    end
  end



end
