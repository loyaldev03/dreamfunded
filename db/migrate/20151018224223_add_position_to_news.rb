class AddPositionToNews < ActiveRecord::Migration
  def change
    add_column :news, :position, :integer, default: 0
  end
end
