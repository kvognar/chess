class AddParentIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :parent_id, :integer, index: true
  end
end
