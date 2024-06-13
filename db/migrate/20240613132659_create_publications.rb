class CreatePublications < ActiveRecord::Migration[7.1]
  def change
    create_table :publications do |t|
      t.references :creator, null: false, foreign_key: { to_table: :users }
      t.string :title
      t.text :description
      t.boolean :to_display, default: true

      t.timestamps
    end
  end
end
