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

      resources :submissions, param: :s_id # use :s_id instead of :id in URLs and route params
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
