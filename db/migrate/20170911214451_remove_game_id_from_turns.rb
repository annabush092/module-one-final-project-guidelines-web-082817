class RemoveGameIdFromTurns < ActiveRecord::Migration[5.0]
  def change
    remove_column :turns, :game_id
  end
end
