Rails.application.routes.draw do
  devise_for :users

  if Rails.env.development?
    mount Lookbook::Engine, at: "/lookbook"
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :library do
    resources :checklists
  end

  namespace :templates do
    resources :checklists
  end

  namespace :settings do
    resource :account, only: %i[show update]
  end


  root to: "home#index"
end
