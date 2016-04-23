ActiveAdmin.register Company do
  controller do
    before_filter :authenticate

    private
    def authenticate
      if user_session.authority != authority[:Admin]
        redirect_to root_path
      end
    end
  end
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :image, :document, :accredited, :hidden, :position, :docusign_url, :user_id, :name, :description, :image, :invested_amount, :website_link, :video_link, :goal_amount, :status, :CEO, :CEO_number, :display, :days_left, :created_at, :updated_at, :suggested_target_price
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
        f.input  :accredited
        f.input  :description
        f.input :image, :required => false, :as => :file
        f.input  :invested_amount
        f.input  :suggested_target_price
        f.input  :website_link
        f.input  :goal_amount
        f.input  :status
        f.input  :video_link
        f.input  :CEO
        f.input :status, :as => :select, collection: [ ["Coming Soon",1], ["Active", 2], ['Funded',3] ]
        f.input  :created_at
        f.input  :updated_at
    end
    f.actions
  end

  show do |ad|
    attributes_table do
      row :name
      row :image do
        image_tag(ad.image.url)
      end
      row :description
      row :invested_amount
      row :suggested_target_price
      row :website_link
      row :goal_amount
      row :video_link
      row :CEO
      row :created_at
      row :updated_at
      # Will display the image on show object page
    end
   end

end
