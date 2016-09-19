class StringFormatInFormc < ActiveRecord::Migration
  def up
      change_column :general_infos, :legal_name, :text
      change_column :general_infos, :prev_emp, :text
      change_column :general_infos, :prev_resp, :text
  end

  def down
      change_column :general_infos, :legal_name, :string
      change_column :general_infos, :prev_emp, :string
      change_column :general_infos, :prev_resp, :string
  end
end
