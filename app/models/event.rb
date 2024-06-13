class Event < ApplicationRecord
    CATEGORIES = ["Atelier", "Concert", "Permanence", "Stage", "Scène ouverte"]
  
    belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  
    validates :creator, presence: true
    validates :category, presence: true, inclusion: { in: CATEGORIES }
    validates :start_date, presence: true, if: :valid_date?
    validates :end_date, presence: true, if: :valid_date?
    validates :location, presence: true
    validates :price, numericality: { greater_than_or_equal_to: 0 }
  
    has_many :event_instruments, dependent: :destroy
    has_many :attendances, dependent: :destroy
    has_many :attendees, through: :attendances, source: :user

    private

    def valid_date?
      return errors.add(:date, 'must exist.') && false unless start_date.present? && end_date.present?
  
      if start_date < Date.today
        errors.add(:date, "can't be past.")
        return false
      elsif end_date < start_date
        errors.add(:date, "can't be before start date")
        return false
      end
  
      return true
    end
  
end
