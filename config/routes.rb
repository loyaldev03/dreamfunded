Rails.application.routes.draw do



  ActiveAdmin.routes(self)
  resources :members

  mount Ckeditor::Engine => '/ckeditor'
  get '/posts/new/:page', to: "posts#new"
  get '/posts/:id/edit/:page', to: "posts#edit"
  resources :posts

  resources :documents
  resources :guests
  resources :bids

  match "/diversity-tech-angels-earn-wings/" => redirect("https://dreamfundedsf.wpengine.com/diversity-tech-angels-earn-wings/"), via: 'get'

  get 'payment/index'
  get 'news/manage'
  get 'welcome/index'
  get 'auth/google_oauth2/callback', to:'omniauth_callbacks#google_oauth2'
  post 'auth/google_oauth2/callback', to:'omniauth_callbacks#google_oauth2'

  get 'auth/linkedin/callback', to:'omniauth_callbacks#google_oauth2'
  post 'auth/linkedin/callback', to:'omniauth_callbacks#google_oauth2'

  # B I D D I N G   S Y S T E M
  get 'bid/:id', to: "bids#bid"
  get 'sellers_bids', to: "bids#sellers_bids"
  get 'accept_bid/:id', to: "bids#accept"
  get 'decline_bid/:id', to: "bids#decline"
  get 'counter_offer/:id', to: "bids#counter_offer"
  post 'send_counter_offer', to: "bids#send_counter_offer"
  get 'confirm', to: "bids#confirm", as: :confirm

  get 'users/portfolio', to: "users#portfolio", as: :portfolio
  get 'users/portfolio_admin/:id', to: "users#portfolio_admin", as: :portfolio_admin
  post 'users/portfolio_admin/:id', to: "users#remove_investment", as: :remove_investment

  get 'new/full/:id', to: "news#full", as: :full_article
  post 'home_controller/create', to: "home#create"
  post 'companies_controller/add_team_member', to: "companies#add_team_member"

  get '/change_password', to: "users#change_password", as: :change_password
  post '/post_change_password', to: "users#post_change_password", as: :post_change_password

  get '/new_password', to: "users#new_password", as: :new_password
  post '/reset_password', to: "users#reset_password", as: :reset_password

  get '/epay', to: "companies#epay", as: :epay
  post '/users/verify', to: 'users#verify', as: 'user_verify'

  get '/users/certify', to: "users#certify", as: 'certify'

  get 'homes/faq', to: "home#faq", as: :faq
  get '/legal', to: "home#legal", as: :legal
  get '/contact', to: 'home#contact_us'
  post '/contact_us', to: 'home#contact_us_send_email'


  get '/liquidate', to: 'home#liquidate'
  post '/liquidate_form', to: 'home#liquidate_form'
  get '/liquidate_after', to: 'home#liquidate_after'

  get '/shares', to: 'sellers#shares'
  get '/edit-shares/:id', to: 'sellers#edit'
  post '/update-shares', to: 'sellers#update'

  get '/home/edit_member/:id', to: "home#team_member_edit"
  put '/home/edit_member', to: 'home#team_member_update'
  # patch '/home/edit_member', to: 'home#team_member_update', as: 'update_member'

  get '/sellers', to: "home#sellers", as: :sellers
  get '/edit_seller/:id', to: "home#edit_seller", as: 'edit_seller'
  patch '/liquidate_shares', to: "home#edit_liq_seller", as: :edit_shareholder

  get '/email_all_investors/:id', to: "home#email_all_investors", as: :email_all_investors

  post 'submit_bid', to: "companies#submit_bid"


  get '/new_seller', to: "home#new_seller"
  post '/new_seller', to: "home#create_new_seller", as: :create_shareholder

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
  get '/how_it_works', to: 'home#howItWorks'
  get '/about', to: 'home#about'
  get '/education', to: 'home#education'

  get '/education/basics', to: 'home#basics', as: 'edication_basics'
  get '/education/investing-tips', to: 'home#tips', as: 'education_tips'
  # get '/education/rules-regulations', to: 'home#rules'
  get '/education/important-terms', to: 'home#terms', as: 'education_terms'
  get '/education/taxes-gains', to: 'home#taxes', as: 'education_taxes'
  get '/education/investor-qa', to: 'home#investorqa', as: 'investorqa'
  get '/education/employee-qa', to: 'home#employeeqa', as: 'employeeqa'
  get '/education/market_trends', to: 'home#market_trends', as: 'market_trends'
  get '/get-funded', to: 'home#contact_us'


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


  resources :users, only: [:edit, :update]
  get ':controller(/:action(/:id))'
  post ':controller(/:action(/:id))'

  # match "/:id" => redirect("/"), via: 'get'
end
