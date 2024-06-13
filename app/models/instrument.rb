class Instrument < ApplicationRecord
    INSTRUMENTS = ['Aucun', 'Guitare', 'Piano', 'Basse', 'MAO', 'Ukulélé', 'Harmonie', 'Batterie', 'Chant']

    validates :name, presence: true, inclusion: { in: INSTRUMENTS }

    has_many :event_instruments

end
