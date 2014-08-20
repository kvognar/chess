class ChangeVisitUserToVisitor < ActiveRecord::Migration
  def change
    rename_column :visits, :user_id, :visitor_id
  end
end
