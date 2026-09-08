require 'rails_helper'

RSpec.describe 'GameTesterController', type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: "/api/v1/game_testers").to route_to("api/v1/game_testers#index")
    end

    it 'routes to #create' do
      expect(post: "/api/v1/game_testers").to route_to("api/v1/game_testers#create")
    end

    it 'routes to #show' do
      expect(get: "/api/v1/game_testers/me").to route_to("api/v1/game_testers#show")
    end

    it 'routes to #update' do
      expect(patch: "/api/v1/game_testers/me").to route_to("api/v1/game_testers#update")
    end
  end
end
