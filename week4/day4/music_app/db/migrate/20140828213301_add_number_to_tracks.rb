class AddNumberToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :track_number, :integer
    change_column :tracks, :track_number, :integer, null: false
  end
end
