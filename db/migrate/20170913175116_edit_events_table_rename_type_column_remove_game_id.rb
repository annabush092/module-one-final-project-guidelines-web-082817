class EditEventsTableRenameTypeColumnRemoveGameId < ActiveRecord::Migration[5.0]
  def change
    rename_column :events, :name, :action_type
    remove_column :events, :game_id
  end
end
