ActiveAdmin.register Logo do
  menu label: "Diversity Network"
  controller do
    before_filter :authenticate

    private
    def authenticate
      if current_user.authority < authority[:Editor]
        redirect_to root_path
      end
    end
  end

  permit_params :name, :info, :image, :position

  form do |f|
    f.inputs 'Details' do
      f.input   :name
      f.input   :info
      f.input   :image, :required => false, :as => :file
      f.input   :position
    end
    f.actions
  end


  show do |ad|
    attributes_table do
      row :name
      row :image do
        image_tag(ad.image.url)
      end
      row :info
      row :position
    end
   end

end
