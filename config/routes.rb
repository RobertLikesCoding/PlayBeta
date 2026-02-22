Rails.application.routes.draw do
  get "passwords/update"
  namespace :api do
    namespace :v1 do
      resources :game_developers, only: [ :index, :create ] do
        collection do
          get "me", to: "game_developers#show"
          patch "me", to: "game_developers#update"
        end
      end

      post "auth/login", to: "auth#login"

      resources :submissions, param: :s_id do # use :s_id instead of :id in URLs and route params
        collection do
          get :constants
        end
      end
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
