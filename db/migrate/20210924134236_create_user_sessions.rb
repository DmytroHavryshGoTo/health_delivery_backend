class CreateUserSessions < ActiveRecord::Migration[6.1]
  def change
    create_table :user_sessions do |t|
      t.string :uuid, null: false, index: true, limit: 36
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
