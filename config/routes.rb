Rails.application.routes.draw do
  get '/new', to: 'games#new', as: :new_game
  post '/score', to: 'games#score', as: :score_game

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'games#new'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
