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
  end

end
