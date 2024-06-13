class Instrument < ApplicationRecord
  INSTRUMENTS = ["Aucun", "Basse", "Batterie", "Chant", "Guitare", "Harmonie", "MAO", "Piano", "Ukulélé"]

  validates :name, presence: true, inclusion: { in: INSTRUMENTS }
end
