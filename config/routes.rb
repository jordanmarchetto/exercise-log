Rails.application.routes.draw do
  get 'recent_workouts', to: 'recent_workouts#index'
  get 'tools', to: 'tools#index'
  get 'records', to: 'records#index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "exercises#index" # TODO: change to login/home

  resources :exercises do
    resources :workout_sets
  end



end
