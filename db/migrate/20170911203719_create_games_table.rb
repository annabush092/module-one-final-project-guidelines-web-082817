class CreateGamesTable < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.integer :community_points
      t.integer :round
    end
  end
end
