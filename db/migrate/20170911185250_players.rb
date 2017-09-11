class Players < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.string :name
      t.integer :knowledge
      t.integer :social
      t.integer :wellbeing
    end
  end
end
