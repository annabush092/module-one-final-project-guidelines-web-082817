class CreateEventsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.integer :game_id
    end
  end
end
