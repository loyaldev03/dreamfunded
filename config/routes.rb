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

  root 'home#index'
  #URLs from old site
  get '/how-it-works', to: 'home#why'
  get '/why-invest-with-dream-funded', to: 'home#why'
  get '/faq', to: 'home#faq'
  get '/about', to: 'home#about'
  get '/portofolio', to: 'companies#index'
  get '/dreamfunded-exchange', to: 'home#exchange'
  get '/our-team', to: 'teams#index'
  match "/our-team/manny-fernandez" => redirect("team/manny-fernandez"), via: 'get'
  match "/our-team/rexford-r-hibbs" => redirect("team/rexford-r-hibbs"), via: 'get'
  match "/our-team/manny-fernandez" => redirect("team/manny-fernandez"), via: 'get'
  match "/our-team/helder-suzuki" => redirect("team/helder-suzuki"), via: 'get'
  match "/our-team/jacob-white" => redirect("team/jacob-white"), via: 'get'
  match "/our-team/bill-payne" => redirect("team/bill-payne"), via: 'get'
  match "/dreamfunded-mentioned-forbes-get-introduced-investors/" => redirect("news/dreamfunded-mentioned-in-forbes"), via: 'get'
  match "/startups-vie-funding-shark-tank-event/" => redirect("news/startups-vie-for-funding-at-shark-tank-event"), via: 'get'
  get '/buy-equity', to: 'users#new'
  get "/information-selling-equity", to: 'home#exchange'
  match "/regulation-mini-ipos-way-rule-change-allows-regular-joes-invest-startups/" => redirect("news/regulation-a-mini-ipos-on-the-way-as-rule-change-allows-regular-joes-to-invest-in-startups"), via: 'get'
  get '/funding', to: 'home#index'



  get ':controller(/:action(/:id))'
  post ':controller(/:action(/:id))'
end
