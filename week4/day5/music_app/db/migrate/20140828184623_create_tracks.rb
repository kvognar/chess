class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :title, null: false
      t.integer :album_id, null: false
      t.string :status, null: false
      t.text :lyrics

      t.timestamps
    end
    add_index :tracks, :title
    add_index :tracks, :album_id
  end
end
