Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :game_developers, only: [ :create ] do
        collection do
          post "sign_up", to: "game_developers#create"
          get "me", to: "game_developers#me"
        end
      end
      post "auth/log_in", to: "auth#login"
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
