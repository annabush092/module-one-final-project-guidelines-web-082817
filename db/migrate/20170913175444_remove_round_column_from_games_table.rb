class RemoveRoundColumnFromGamesTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :games, :round
  end
end
