class Publication < ApplicationRecord

  has_one_attached :publication_picture
  belongs_to :creator, class_name: 'User'
  
  validates :title, presence: true
  validates :description, presence: true
  validates :to_display, presence: true, inclusion: { in: [true, false] }


  def publication_picture_url
    if publication_picture.attached?
      Rails.application.routes.url_helpers.rails_blob_url(publication_picture, host: Rails.application.routes.default_url_options[:host])
    else
      nil
    end
  end



end
