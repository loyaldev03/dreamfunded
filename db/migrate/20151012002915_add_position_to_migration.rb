class AddPositionToMigration < ActiveRecord::Migration
  def change
    add_column :companies, :position, :integer, default: 0
  end
end
