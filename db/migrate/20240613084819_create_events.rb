class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.references :creator, foreign_key: { to_table: :users }
      t.string :category
      t.integer :price
      t.datetime :start_date
      t.datetime :end_date
      t.string :location
      t.text :description

      t.timestamps
    end
  end
end
