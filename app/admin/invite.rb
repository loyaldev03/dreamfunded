ActiveAdmin.register Invite  do
  menu label: "Uploaded Emails"
  controller do
    before_filter :authenticate

    private
    def authenticate
      if current_user.authority != authority[:Admin]
        redirect_to root_path
      end
    end

  end


permit_params  :user_id, :email, :token, :created_at, :updated_at, :accepted, :signedup, :status, :name
  before_filter :only => [:show, :edit, :update, :destroy] do
      @company = Company.find_by_slug(params[:id])
  end

  index :title => 'Uploaded Emails' do
    column  "name"
    column  "email"
    column("User") { |company| link_to(company.user.name, admin_user_path(company.user)) }
    column  "created_at"
    actions
  end

  form do |f|
    f.inputs 'Company Details' do
        f.input  :name
        f.input  :email
        f.input  :user
        f.input  :created_at
        f.input  :updated_at
    end
    f.actions
  end

  show do |ad|
    attributes_table do
      row :name
      row :email
      row :user
      row :created_at
      row :updated_at
      # Will display the image on show object page
    end
   end


end
