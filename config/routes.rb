Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
    resources :users
    resources :sessions
  # Defines the root path route ("/")
  # root "articles#index"
  root "sessions#new"
  get "/login", to: "sessions#new", as: "login"
  post "/login", to: "sessions#create"

  get "/signup_user", to: "signup_user#new", as: "signup_user"
  post "/signup_user", to: "signup_user#create"

end
