ActiveAdmin.register Company do
  controller do
    before_filter :authenticate

    private
    def authenticate
      if current_user.authority < authority[:Editor]
        redirect_to root_path
      end
    end

    def description_step?(company)
      state = company.campaign.current_state if company.campaign
      status = true
      if state == "goal"
        status = false
      elsif state == "basics"
        status = false
      end
      status
    end
    helper_method :description_step?

  end

filter :name

permit_params :image, :document, :end_date, :accredited, :hidden, :position, :docusign_url, :user_id, :name, :description, :image, :invested_amount, :website_link, :video_link, :goal_amount, :status, :CEO, :CEO_number, :display, :days_left, :created_at, :updated_at, :fund_america_code, :suggested_target_price, :min_investment
before_filter :only => [:show, :edit, :update, :destroy] do
    @company = Company.find_by_slug(params[:id])
end

  index do
    column  "name"
    column("url") {|t| link_to t.name, "/companies/#{t.slug}" if description_step?(t) }
    column  "website_link"
    column  "goal_amount"
    column("Step") { |company| company.campaign.current_state if company.campaign }
    column("User") { |company| link_to(company.users.first.name, admin_user_path(company.users.first)) if company.users.any?}
    column("Phone") { |company| company.users.first.phone if company.users.any?}
    column("Phone") { |company| company.users.first.email if company.users.any?}
    column  "created_at"
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
        f.input  :min_investment
        f.input  :status
        f.input  :video_link
        f.input  :fund_america_code
        f.input  :CEO
        f.input  :hidden
        f.input :status, :as => :select, collection: [ ["Coming Soon",1], ["Active", 2], ['Funded',3] ]
        f.input  :end_date
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
      row :min_investment
      row :video_link
      row :CEO
      row :fund_america_code
      row :end_date
      row :hidden
      row :created_at
      row :updated_at
      # Will display the image on show object page
    end
   end

   csv do
      column :name
      column("User") {|company| company.users.first.first_name if company.users.any?}
      column("Phone") { |company| company.users.first.phone if company.users.any?}
      column("Email") { |company| company.users.first.email if company.users.any?}
    end


end
