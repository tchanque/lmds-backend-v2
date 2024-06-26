class CreateSkills < ActiveRecord::Migration[7.1]
  def change
    create_table :skills do |t|
      t.references :musician, foreign_key: { to_table: :users }
      t.references :instrument, foreign_key: true
      t.integer :level, default: 1

      t.timestamps
    end
  end
end
