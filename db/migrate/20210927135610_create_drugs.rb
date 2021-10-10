class CreateDrugs < ActiveRecord::Migration[6.1]
  def change
    create_table :drugs do |t|
      t.references :delivery, null: false, foreign_key: true
      t.decimal :min_temperature, default: 0
      t.decimal :min_humidity, default: 0
      t.decimal :max_temperature, default: 0
      t.decimal :max_humidity, default: 0
      t.string :name, null: false
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
