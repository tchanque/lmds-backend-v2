class CreateAttendances < ActiveRecord::Migration[7.1]
  def change
    create_table :attendances do |t|
      t.references :attendee, null: false, foreign_key: { to_table: :users }
      t.references :event, null: false, foreign_key: true
      t.boolean :is_pending, default: false
      t.references :event_instrument, null: false, foreign_key: true

      t.timestamps
    end
  end
end
