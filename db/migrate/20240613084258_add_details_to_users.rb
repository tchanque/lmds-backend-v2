class AddDetailsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :description, :text
    add_column :users, :role, :string
    add_column :users, :is_subscriber, :boolean
    add_column :users, :subscription_end_date, :datetime
  end
end
