class DropCommunityPointsColumnFromGamesTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :games, :community_points
  end
end
