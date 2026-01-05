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

  get "/home-page", to: "rota#trajetoria", as: :homePage


  resources :users, only: [ :index, :edit, :update, :show, :destroy ]
  scope :profile do
    get "edit", to: "users#edit", as: :edit_profile
    patch "/", to: "users#update", as: :profile
    delete "Excluir", to: "users#destroy", as: :destroy
    put "/", to: "users#update"
    get "/", to: "users#show", as: :profileUser
  end

  resources :schedules, only: %i[ index new create edit update show destroy ]

  resources :rota, only: [] do
    member do
      get :trajetoria
    end
  end



  get "schedule", to: "schedules#schedule_user", as: :scheduleUser


  # autentication
  get "signup", to: "users#new"
  post "signup", to: "users#create"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  # verification
  get "verification", to: "send_email#verification_email_code"
  post "verification", to: "send_email#verification_email_code"

  # resend email
  get "resend-email", to: "send_email#resend_email"
  post "resend-email", to: "send_email#resend_email"

  # reset password
  get "password/reset/", to: "reset_passwords#new"
  post "password/reset/", to: "reset_passwords#create"
  get "password/reset/edit", to: "reset_passwords#edit"
  patch "password/reset/edit", to: "reset_passwords#update"

  # change email
  get "change/email", to: "users#update_email"
  patch "change/email", to: "users#update_email"

end
