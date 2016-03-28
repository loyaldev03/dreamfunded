ActiveAdmin.register User do
  controller do
    before_filter :authenticate

    private
    def authenticate
      if user_session.authority != authority[:Admin]
        redirect_to root_path
      end
    end
  end

permit_params :first_name, :last_name, :login, :email, :authority, :salt, :password_digest, :confirmed, :invested_amount, :phone

  index do
    column  "first_name"
    column  "last_name"
    column  "email"
    column  "authority"
    column  "confirmed"
    column  "invested_amount"
    column  "phone"
    column  "provider"
    column  "created_at"
    column  "updated_at"
    actions
  end




end
