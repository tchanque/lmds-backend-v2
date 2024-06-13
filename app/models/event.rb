class Event < ApplicationRecord
    CATEGORIES = ["Atelier", "Concert", "Permanence", "Stage", "Scène ouverte"]
  
    belongs_to :creator, class_name: 'User'
  
    validates :creator, presence: true
    validates :category, presence: true, inclusion: { in: CATEGORIES }
    validates :start_date, presence: true, if: :valid_date?
    validates :end_date, presence: true, if: :valid_date?
    validates :location, presence: true
    validates :price, numericality: { greater_than_or_equal_to: 0 }
  

    private

    def valid_date?
      return errors.add(:La_date, 'doit être renseignée.') && false unless start_date.present? && end_date.present?
  
      if start_date < Date.today
        errors.add(:La_date, 'ne peut pas être passée.')
        return false
      elsif end_date < start_date
        errors.add(:La_date, "ne peut pas être inférieure à la date de début d'événement")
        return false
      end
  
      return true
    end
  
end
