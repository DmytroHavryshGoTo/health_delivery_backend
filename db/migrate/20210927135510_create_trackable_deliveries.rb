class CreateTrackableDeliveries < ActiveRecord::Migration[6.1]
  def change
    create_table :trackable_deliveries do |t|
      t.references :user, null: false, foreign_key: true
      t.references :delivery, null: false, foreign_key: true
      t.timestamps
    end
  end
end
