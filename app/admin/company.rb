ActiveAdmin.register Company do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end
  index do
    column  "name"
    column  "description"
    column  "invested_amount"
    column  "website_link"
    column  "goal_amount"
    column  "CEO"
    column  "created_at"
    column  "updated_at"
    actions
  end

  form do |f|
    f.inputs 'Company Details' do
        f.input  :name
        f.input  :description
        f.input  :invested_amount
        f.input  :website_link
        f.input  :goal_amount
        f.input  :CEO
        f.input  :created_at
        f.input  :updated_at
    end
    f.actions
  end

end
