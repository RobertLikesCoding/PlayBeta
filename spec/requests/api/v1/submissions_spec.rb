require 'rails_helper'

RSpec.describe "Api::V1::Submissions", type: :request do
  let(:game_developer) { create(:game_developer) }
  let(:submissions) { create_list(:submission, 3, game_developer:) }
  let(:jwt_secret) { ENV['JWT_SECRET_KEY'] }
  let(:token) { JWT.encode({ user_id: game_developer.id }, jwt_secret, "HS256") }
  let(:headers) { { "Authorization" => "Bearer #{token}" } }

  describe "GET /index" do
    before { create_list(:submission, 3, game_developer:) }

    it "should return all submissions for the current user" do
      get "/api/v1/submissions", headers: headers

      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["data"]["message"]).to include("Successfully loaded submissions of")
      expect(json["data"]["submissions"].size).to eq(3)
    end
  end

  describe "GET /show" do
    it "should return a submission" do
    end
  end
end
