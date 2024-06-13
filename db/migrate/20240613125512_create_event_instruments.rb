class CreateEventInstruments < ActiveRecord::Migration[7.1]
  def change
    create_table :event_instruments do |t|
      t.references :event, foreign_key: { to_table: :events }
      t.references :instrument, foreign_key: { to_table: :instruments }
      t.integer :total_spots
      t.integer :available_spots
      t.integer :level

      t.timestamps
    end
  end
end
