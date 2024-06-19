class ChangeLevelType < ActiveRecord::Migration[7.1]
  def change
    change_column(:event_instruments, :level, :string)
  end
end
