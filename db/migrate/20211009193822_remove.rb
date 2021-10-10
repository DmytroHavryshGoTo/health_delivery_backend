class Remove < ActiveRecord::Migration[6.1]
  def change
    drop_table :damage_details
  end
end
