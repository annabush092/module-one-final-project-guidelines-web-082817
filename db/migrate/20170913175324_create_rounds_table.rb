class CreateRoundsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :rounds do |t|
      t.integer :game_id
      t.integer :event_id
    end
  end
end
