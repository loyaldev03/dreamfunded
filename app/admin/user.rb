ActiveAdmin.register User do
  controller do
    before_filter :authenticate

    private
    def authenticate
      if current_user.authority != authority[:Admin]
        redirect_to root_path
      end
    end
  end

   filter :first_name
   filter :last_name
   filter :email
   filter :created_at
   filter :confirmed
   filter :advisor

permit_params :first_name, :last_name, :login, :email, :position, :image, :title, :bio, :role, :advisor,  :authority, :salt, :password, :password_confirmation, :confirmed, :invested_amount, :phone

  index do
    column  "first_name"
    column  "last_name"
    column  "email"
    column  "authority"
    column  "confirmed"
    column  "advisor"
    column("Company") { |user| user.company.name if user.company }
    column  "invested_amount"
    column  "phone"
    column  "provider"
    column  "created_at"
    column  "updated_at"
    actions
  end

  form do |f|
    f.inputs 'User Details' do
      f.input   :first_name
      f.input   :last_name
      f.input   :login
      f.input   :email
      f.input   :authority
      f.input   :title
      f.input   :bio
      f.input   :image, :required => false, :as => :file
      f.input   :advisor
      f.input   :position
      f.input   :role
      f.input   :salt
      f.input   :password
      f.input   :password_confirmation
      f.input   :confirmed
      f.input   :invested_amount
      f.input   :phone
      f.input   :role
    end
    f.actions
  end

  show do |ad|
    attributes_table do
      row :first_name
      row :last_name
      row :email
      row :phone
      row :authority
      row :title
      row :image do
        image_tag(ad.image.url)
      end
      row :advisor
      row :confirmed
      row :invested_amount
      row :created_at
      row :updated_at
      # Will display the image on show object page
    end
   end


  controller do

     def update
       if params[:user][:password].blank?
         params[:user].delete("password")
         params[:user].delete("password_confirmation")
       end
       super
     end

  end

  csv do
     column :first_name
     column :last_name
     column :email
   end

end
