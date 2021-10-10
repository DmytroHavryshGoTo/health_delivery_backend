class CreateDamageDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :damage_details do |t|
      t.string :reason
      t.references :drug, null: false, foreign_key: true
      t.decimal :lat, null: false
      t.decimal :lon, null: false
      t.timestamps
    end
  end
end
