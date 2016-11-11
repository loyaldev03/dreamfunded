class AddPositionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :position, :integer, default: 0
  end
end
