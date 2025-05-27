Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  root "fridges#index"
  get "up" => "rails/health#show", as: :rails_health_check

  resources :fridges, only: [:create, :show, :update, :destroy]
  resources :recipes, only: [:create, :show, :update, :destroy]
  resources :shopping_lists, only: [:create, :show, :update, :destroy]

  # Defines the root path route ("/")
  # root "posts#index"
end
