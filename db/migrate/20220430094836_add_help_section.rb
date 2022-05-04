class AddHelpSection < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :need_help, :boolean, default: false, null: false
    add_column :users, :phone_number, :string

    create_table :ads do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.string :description, null: false
      t.boolean :completed, default: false, null: false
      t.references :user, null: false
    
      t.timestamps
    end

    add_reference :deliveries, :ad, index: true
  end
end
