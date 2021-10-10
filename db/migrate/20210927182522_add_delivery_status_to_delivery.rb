class AddDeliveryStatusToDelivery < ActiveRecord::Migration[6.1]
  def change
    add_column :deliveries, :delivery_status, :integer, default: 0
  end
end
