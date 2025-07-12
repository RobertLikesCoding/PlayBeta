Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :game_developers, only: [ :index, :create ] do
        collection do
          get "me", to: "game_developers#show"
          patch "me", to: "game_developers#update"
        end
      end
      post "auth/login", to: "auth#login"
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
