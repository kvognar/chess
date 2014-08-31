class AddSlugToSubs < ActiveRecord::Migration
  def change
    add_column :subs, :slug, :string
    add_index :subs, :slug, unique: true
  end
end
