class AddDeviceColumnAndLocationColumnToSession < ActiveRecord::Migration
  def change
    add_column :sessions, :device, :string
    add_column :sessions, :location, :string
  end
end
