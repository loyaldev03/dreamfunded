class ChangeDocusign < ActiveRecord::Migration
  def change
    change_column :docusigns, :envelope_id, :string
  end
end
