class CreateDeliveries < ActiveRecord::Migration[6.1]
  def change
    create_table :deliveries do |t|
      t.references :user, null: false, foreign_key: true
      t.json :route, null: false
      t.integer :status, default: 0
      t.string :ttn, null: false, index: true, uniq: true
      t.datetime :estimated_delivery_date
      t.string :name, null: false
      t.timestamps
    end
  end
end
