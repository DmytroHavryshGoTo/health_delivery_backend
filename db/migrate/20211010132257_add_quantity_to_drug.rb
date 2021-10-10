class AddQuantityToDrug < ActiveRecord::Migration[6.1]
  def change
    add_column :drugs, :quantity, :integer, null: false
  end
end
