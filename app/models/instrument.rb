class Instrument < ApplicationRecord
    INSTRUMENTS = ['Aucun', 'Guitare', 'Piano', 'Basse', 'MAO', 'Ukulélé', 'Harmonie', 'Batterie', 'Chant']

    validates :name, presence: true, inclusion: { in: INSTRUMENTS }

    has_many :skills, dependent: :destroy
    has_many :event_instruments, dependent: :destroy

end
