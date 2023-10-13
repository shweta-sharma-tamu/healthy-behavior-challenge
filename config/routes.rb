Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
    resources :users

    resources :sessions, only: [:new, :create, :destroy]

    resources :instructors, only: [:show], param: :instructor_id 

  root 'sessions#new'
  get "/login", to: "sessions#new", as: "login"
  post '/login', to: 'sessions#create'
  get "/instructor_signup/:token/", to: "instructors#new", as: "instructor_signup"
  post '/instructor_signup/:token/', to: 'instructors#create'
  get '/signout', to: 'sessions#destroy', as: 'signout'

  get "password/reset", to: "password_resets#new"
  post "password/reset", to: "password_resets#create"
  get   "password/reset/edit", to: "password_resets#edit"
  patch "password/reset/edit", to: "password_resets#update"

  get "/trainee_signup", to: "trainee_signup#new", as: "trainee_signup"
  post "/trainee_signup", to: "trainee_signup#create"
  get 'instructor_referral', to: 'instructor_referral#index'
  post 'instructor_referral', to: 'instructor_referral#create'

 
  resources :challenges do
    member do
      get 'add_trainees', to: "challenges#add_trainees" # This defines the "Add Users" action for a specific challenge
      post 'update_trainees', to: "challenges#update_trainees"  # This defines the action to handle form submission
    end
  end

  resources :challenges do
      get "/trainees", controller:'challenges' ,action: 'trainees_list', constraints: { query_string: /(.+)?/ }, as: "list_trainees"
  end

end

