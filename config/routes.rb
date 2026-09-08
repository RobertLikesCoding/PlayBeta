Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :game_developers, only: [ :index, :create ] do
        collection do
          get "me", to: "game_developers#show"
          patch "me", to: "game_developers#update"
        end
      end

      resources :game_testers, only: [ :index, :create ] do
        collection do
          get "me", to: "game_testers#show"
          patch "me", to: "game_testers#update"
        end
      end

      patch "passwords/update", to: "passwords#update"
      post "auth/developer_login", to: "auth#developer_login"
      post "auth/tester_login", to: "auth#tester_login"

      resources :submissions, param: :s_id do # use :s_id instead of :id in URLs and route params
        collection do
          get :constants
        end
      end
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
