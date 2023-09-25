Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/", to: "main#index", as: "root"
  get "/instructor_signup", to: "instructor#new", as: "new_instructor_signup"
  post '/instructor_signup', to: 'instructor#create'
end
