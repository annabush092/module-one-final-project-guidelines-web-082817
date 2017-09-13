class AddWinLossColumnToGamesTable < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :win_loss, :string
  end
end
