class AddLonAndLatToDelivery < ActiveRecord::Migration[6.1]
  def change
    add_column :deliveries, :lat, :decimal
    add_column :deliveries, :lon, :decimal
  end
end
