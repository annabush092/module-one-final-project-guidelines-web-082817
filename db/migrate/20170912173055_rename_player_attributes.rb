class RenamePlayerAttributes < ActiveRecord::Migration[5.0]
  def change
    rename_column :players, :knowledge, :technical_skills
    rename_column :players, :social, :soft_skills
  end
end
