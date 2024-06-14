class CreateAttendances < ActiveRecord::Migration[7.1]
  def change
    create_table :attendances do |t|
      t.references :attendee, foreign_key: { to_table: :users }
      t.references :event, foreign_key: true
      t.boolean :is_pending
      t.references :event_instrument, foreign_key: true

      t.timestamps
    end
  end
end
