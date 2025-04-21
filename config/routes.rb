Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :game_developers, only: [ :index ] do
        collection do
          post "signup", to: "game_developers#create"
          get "me", to: "game_developers#me"
        end
      end
      post "auth/login", to: "auth#login"
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
