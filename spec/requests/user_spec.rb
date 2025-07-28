require 'rails_helper'

RSpec.describe "Users", type: :request do
  context 'routes' do
    routes = {
      free_authenticate_pages: [ "login", "signup", "" ],
      pages: [ "home-page" ],
      user_pages: [ "profile" ],
      admin_pages: [ "users", "users/1/edit", "users/1", "users/new" ],
      onibus_page: [ "onibuses", "onibuses/new", "onibuses/1" ],
      verification_pages: [ "verification" ]
    }

    all_routes = routes.values.flatten



    it "redirect to home-page users authenticates" do
      routes_authenticate = routes[:free_authenticate_pages]
      user_test = User.create(valid_user_attributes)
      post "/login", params: session_params_for(user_test)

      routes_authenticate.each do |link|
        get "/#{link}"
        follow_redirect!
      end
    end

    it "redirect unauthenticated users trying to access any page" do
      all_routes.each do |link|
        get "/#{link}"

        if routes[:free_authenticate_pages].include?(link)
          expect(response.body).to_not include("Você precisa estar logado para acessar a página.")
        else
          follow_redirect!
          expect(response.body).to include("Você precisa estar logado para acessar a página.")
        end
      end
    end
  end
end
