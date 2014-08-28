class CreateSessions < ActiveRecord::Migration
  def change
    remove_column :users, :session_token
    create_table :sessions do |t|
      t.integer :user_id, null: false
      t.string :session_token, null: false
    end
    add_index :sessions, :user_id
    add_index :sessions, :session_token, unique: true
  end
end
