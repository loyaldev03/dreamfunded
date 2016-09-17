class AddFieldsToGeneralInfo < ActiveRecord::Migration
  def change
    add_column :general_infos, :max_amount, :string

    add_column :general_infos, :type_of_securtity, :string
    add_column :general_infos, :legal_name, :string
    add_column :general_infos, :position_title, :string

    add_column :general_infos, :first_date, :date


    add_column :general_infos, :prev_emp, :string
    add_column :general_infos, :prev_title, :string
    add_column :general_infos, :prev_dates, :string
    add_column :general_infos, :prev_resp, :string

    add_column :general_infos, :offering_purpose, :text
    add_column :general_infos, :fin_condition, :text


  end
end
