class ChangeTypeToActionType < ActiveRecord::Migration[5.0]
  def change
    rename_column :actions, :type, :action_type
  end
end
