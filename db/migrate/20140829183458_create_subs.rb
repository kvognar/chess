class CreateSubs < ActiveRecord::Migration
  def change
    create_table :subs do |t|
      t.string :title, null: false, unique: true, index: true
      t.text :description, null: false
      t.integer :moderator_id, null: false, index: true

      t.timestamps
    end
  end
end
