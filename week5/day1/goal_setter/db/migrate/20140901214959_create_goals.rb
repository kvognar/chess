class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.references :user
      t.string :title
      t.text :description
      t.boolean :private, default: false

      t.timestamps
    end
    add_index :goals, [:user_id, :description], unique: true
  end
end
