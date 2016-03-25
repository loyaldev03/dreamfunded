ActiveAdmin.register User do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :first_name, :last_name, :login, :email, :authority, :salt, :password_digest, :confirmed, :invested_amount, :phone
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end

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
