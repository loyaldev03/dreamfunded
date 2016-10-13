ActiveAdmin.register CsvFile  do
  menu label: "CSV Files"
  controller do
    before_filter :authenticate

    private
    def authenticate
      if current_user.authority != authority[:Admin]
        redirect_to root_path
      end
    end

  end


permit_params  :user_id, :file, :created_at, :updated_at


  index :title => 'Uploaded Emails' do
    column("User Emails") { |csv_file| csv_file.user.email }
    column("User") { |csv_file| link_to(csv_file.user.name, admin_user_path(csv_file.user)) }
    column("File") { |csv_file| link_to(csv_file.file.name, csv_file.file.url) if csv_file.file?}
    column  "created_at"
    actions
  end

  form do |f|
    f.inputs 'Company Details' do

        f.input  :created_at
        f.input  :updated_at
    end
    f.actions
  end

  show do |ad|
    attributes_table do

      row :created_at
      row :updated_at
      # Will display the image on show object page
    end
   end


end
