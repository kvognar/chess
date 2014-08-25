class ChangeUsersTable < ActiveRecord::Migration
  def change
    drop_table :users
    create_table :users do |t|
      t.string :username, unique: true, null: false
    end
    add_index :users, :username
  end
end
