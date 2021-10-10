class AddUniqIdToDrug < ActiveRecord::Migration[6.1]
  def change
    add_column :drugs, :container_id, :string, uniq: true
  end
end
