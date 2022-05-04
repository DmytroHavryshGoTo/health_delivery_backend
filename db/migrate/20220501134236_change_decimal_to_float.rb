class ChangeDecimalToFloat < ActiveRecord::Migration[6.1]
  def change
    change_column :deliveries, :lat, :float
    change_column :deliveries, :lon, :float
  end
end
