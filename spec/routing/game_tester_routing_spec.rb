require 'rails_helper'

RSpec.describe 'GameTesterController', type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: "/game_tester/index").to route_to("game_tester#index")
    end
    it 'routes to #show' do
      expect(get: "/game_tester/show").to route_to("game_tester#show")
    end
    it 'routes to #create' do
      expect(get: "/game_tester/create").to route_to("game_tester#create")
    end
    it 'routes to #update' do
      expect(get: "/game_tester/update").to route_to("game_tester#update")
    end
    it 'routes to #delete' do
      expect(get: "/game_tester/delete").to route_to("game_tester#delete")
    end
  end
end
