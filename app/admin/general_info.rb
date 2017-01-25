ActiveAdmin.register GeneralInfo  do
  menu label: "Form C"
  controller do
    before_filter :authenticate

    private
    def authenticate
      if current_user.authority != authority[:Admin]
        redirect_to root_path
      end
    end

  end

config.filters = false
permit_params  :user_id, :file, :created_at, :updated_at


  index :title => 'Form C' do
    column("FormC QA") { |general_info| link_to(general_info.company.name, formc_show_path(general_info)) }
    actions
  end

  # form do |f|
  #   f.inputs 'Company Details' do

  #       f.input  :created_at
  #       f.input  :updated_at
  #   end
  #   f.actions
  # end

  # show do |ad|
  #   attributes_table do

  #     row :created_at
  #     row :updated_at
  #     # Will display the image on show object page
  #   end
  #  end


end
