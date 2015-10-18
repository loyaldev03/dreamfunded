Rails.application.routes.draw do
  resources :documents

  match "/diversity-tech-angels-earn-wings/" => redirect("https://dreamfundedsf.wpengine.com/diversity-tech-angels-earn-wings/"), via: 'get'

  get 'payment/index'



  get 'news/manage'

  get 'welcome/index'

  get 'new/full/:id', to: "news#full", as: :full_article
  post 'home_controller/create', to: "home#create"
  post 'companies_controller/add_team_member', to: "companies#add_team_member"

  get '/change_password', to: "users#change_password", as: :change_password
  post '/post_change_password', to: "users#post_change_password", as: :post_change_password

  get '/new_password', to: "users#new_password", as: :new_password
  post '/reset_password', to: "users#reset_password", as: :reset_password

  get '/epay', to: "companies#epay", as: :epay
  post '/users/verify', to: 'users#verify', as: 'user_verify'

  get 'homes/faq', to: "home#faq", as: :faq
  get '/legal', to: "home#legal", as: :legal
  get '/contact', to: 'home#contact_us'
  post '/contact_us', to: 'home#contact_us_send_email'

  get '/liquidate', to: 'home#liquidate'
  post '/liquidate_form', to: 'home#liquidate_form'
  get '/liquidate_after', to: 'home#liquidate_after'

  get '/home/edit_member/:id', to: "home#team_member_edit", as: :edit_member
  patch '/home/edit_member', to: 'home#team_member_update', as: 'update_member'

  resources :companies
  resources :news
  #resources :teams
  get '/team', to: "teams#index", as: :teams
  get '/team/:id', to: "teams#show", as: :team

  get '/payment', to: "payments#index", as: :payment
  post '/submit_payment', to: "payments#payment"

  get '/thank_you', to: "companies#thank_you"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  get ':controller(/:action(/:id))'
  post ':controller(/:action(/:id))'
end
