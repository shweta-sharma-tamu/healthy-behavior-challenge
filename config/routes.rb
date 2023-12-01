Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
    resources :users

    resources :sessions, only: [:new, :create, :destroy]

    resources :instructors, only: [:show], param: :instructor_id do
      get 'past_challenges', on: :member, to: "instructors#show_prev_challenges", as: "past_challenges"
      get 'upcoming_challenges', on: :member, to: "instructors#show_future_challenges", as: "upcoming_challenges"
    end


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

  get "/todo_list" , to: "todo_list#show", as: "todo_list"
  patch "/todo_list/mark_as_completed", to: "todo_list#mark_as_completed", as: "mark_as_complete"

  get "/trainees/:trainee_id", to: "challenges#show_challenge_trainee", as: "show_challenge_trainee"

  get "/trainees/:trainee_id/edit_todo_list/:challenge_id", to: "todo_list#edit", as: "edit_trainee_todo_list"
  patch "/trainees/:trainee_id/challenges/:challenge_id", to: "todo_list#update", as: "update_trainee_todo_list"

  get "challenges", to: "trainees#show_challenges", as: "show_challenges"

  resources :challenges do
    member do
      get 'edit', to: "challenges#edit"
      post 'update', to: "challenges#update", as: "update"
      get 'add_trainees', to: "challenges#add_trainees" # This defines the "Add Users" action for a specific challenge
      post 'update_trainees', to: "challenges#update_trainees"  # This defines the action to handle form submission
      get '/delete_trainee', as: "delete_trainee",controller:'challenges' ,action: 'delete_trainee'
    end
  end

  resources :challenges do
      get "/trainees", controller:'challenges' ,action: 'trainees_list', constraints: { query_string: /(.+)?/ }, as: "list_trainees"
      get 'task_progress', on: :member, as: "graph"
  end
  post 'filter_data' => 'challenges#filter_data'

  get '/profile', to: 'profiles#show', as: "profile"
  get '/edit_profile', to: 'profiles#edit', as: "edit_profile"
  patch '/update_profile', to: 'profiles#update', as: "update_profile"

  get 'trainee_profile', to: 'trainee_profile#show'
  get 'edit_trainee_profile', to: 'trainee_profile#edit'
  patch 'trainee_profile', to: 'trainee_profile#update'

end

