Rails.application.routes.draw do
  resources :onibuses
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "onibuses#home"

  get "/home-page", to: "onibuses#onibuses_routes", as: :homePage


  resources :users, only: [ :index, :edit, :update, :show, :destroy ]
  scope :profile do
    get "edit", to: "users#edit", as: :edit_profile
    patch "/", to: "users#update", as: :profile
    delete "Excluir", to: "users#destroy", as: :destroy
    put "/", to: "users#update"
    get "/", to: "users#profileUser", as: :profileUser
  end

  resources :schedules, only: %i[ index edit update show destroy]

  scope :schedule do
    get "/", to: "schedules#schedule_user", as: :scheduleUser
    put "/", to: "schedules#update"
    delete "Excluir", to: "schedules#destroy", as: :destroy_schedule
  end


  # autentication
  get "signup", to: "users#new"
  post "signup", to: "users#create"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"


  get "verification", to: "users#verification_email_code"
  post "verification", to: "users#verification_email_code"
end
