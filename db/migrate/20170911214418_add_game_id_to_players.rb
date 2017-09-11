class AddGameIdToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :game_id, :integer
  end
end
