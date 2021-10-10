class RemoveStatusFromDelivery < ActiveRecord::Migration[6.1]
  def change
    remove_column :deliveries, :status
  end
end
