Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
    resources :users
    resources :sessions, only: [:new, :create, :destroy]
  # Defines the root path route ("/")
  # root "articles#index"
  #get "/", to: "main#index", as: "root"
  
  root 'sessions#new'
  get "/login", to: "sessions#new", as: "login"
  post '/login', to: 'sessions#create'
  get "/instructor_signup", to: "instructor#new", as: "instructor_signup"
  post '/instructor_signup', to: 'instructor#create'
  get '/signout', to: 'sessions#destroy', as: 'signout'

  get "password/reset", to: "password_resets#new"
  post "password/reset", to: "password_resets#create"
  get   "password/reset/edit", to: "password_resets#edit"
  patch "password/reset/edit", to: "password_resets#update"

  get "/trainee_signup", to: "trainee_signup#new", as: "trainee_signup"
  post "/trainee_signup", to: "trainee_signup#create"
end

