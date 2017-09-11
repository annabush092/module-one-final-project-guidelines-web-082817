class CreateTurnsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :turns do |t|
      t.integer :player_id
      t.integer :action_id
      t.integer :game_id
    end
  end
end
