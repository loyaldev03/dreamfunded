class AddPositionToLogos < ActiveRecord::Migration
  def change
    add_column :logos, :position, :integer
  end
end
