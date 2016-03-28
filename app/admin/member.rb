ActiveAdmin.register Member do
  controller do
    before_filter :authenticate

    private
    def authenticate
      if user_session.authority != authority[:Admin]
        redirect_to root_path
      end
    end
  end

permit_params :name, :summary, :fullbio, :title, :rank, :image
before_filter :only => [:show, :edit, :update, :destroy] do
    @member = Member.find_by_slug(params[:id])
end

 index do
    column  "name"
    column  "title"
    column  "rank"
    column  "created_at"
    column  "updated_at"
    actions
  end

  form do |f|
    f.inputs 'Member Details' do
        f.input  "name"
        f.input "title"
        f.input :image, :required => false, :as => :file
        f.input "summary"
        f.input "fullbio"
        f.input "rank"
    end
    f.actions
  end

  show do |ad|
    attributes_table do
      row :name
      row :image do
        image_tag(ad.image.url)
      end
      row :title
      row :summary
      row :fullbio
      row :rank
      row :created_at
      row :updated_at
      # Will display the image on show object page
    end
   end

end
