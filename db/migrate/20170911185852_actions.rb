class Actions < ActiveRecord::Migration[5.0]
  def change
    create_table :actions do |t|
      t.string :type
    end
  end
end
