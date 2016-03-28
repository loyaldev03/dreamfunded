ActiveAdmin.register News do
  controller do
    before_filter :authenticate

    private
    def authenticate
      if user_session.authority != authority[:Admin]
        redirect_to root_path
      end
    end
  end

permit_params :image, :title, :content, :source, :position, :video_link
before_filter :only => [:show, :edit, :update, :destroy] do
    @news = News.find_by_slug(params[:id])
end
  index do
    column  "title"
    column  "source"
    column  "created_at"
    column  "updated_at"
    actions
  end

  form do |f|
    f.inputs 'News Details' do
        f.input :image, :required => false, :as => :file
        f.input "title"
        f.input "content"
        f.input "source"
        f.input "position"
        f.input "video_link"
    end
    f.actions
  end

  show do |ad|
    attributes_table do
      row :title
      row :source
      row :image do
        image_tag(ad.image.url)
      end
      row :content
      row :video_link
      row :position
      row :created_at
      row :updated_at
      # Will display the image on show object page
    end
   end

end
