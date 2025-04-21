require 'rails_helper'

RSpec.describe "Api::V1::GameDevelopers", type: :request do
  let(:user) { create(:game_developer) }

  describe "GET /index" do
    before do
      create_list(:game_developer, 2)
    end

    it "returns a list of game developers" do
      get "/api/v1/game_developers"

      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body)
      expect(json_response.size).to eq(2)

      json_response.each do |developer|
        expect(developer).to_not have_key("password_digest")
      end
    end
  end

  describe "GET game_developers/me" do
    context "when authenticated" do
      before do
        token = JWT.encode({ user_id: user.id }, ENV["JWT_SECRET_KEY"], "HS256")
        get "/api/v1/game_developers/me", headers: { "Authorization" => "Bearer #{token}" }
      end

      it "returns the current user" do
        expect(response).to have_http_status(:ok)

        current_user = JSON.parse(response.body)
        expect(current_user["id"]).to eq(user.id)
        expect(current_user["bio"]).to eq(user.bio)
        expect(current_user["email"]).to eq(user.email)
        expect(current_user["password_digest"]).to_not be_present
      end
    end
  end

  describe "POST /api/v1/game_developers" do
    context "with valid params" do
      let(:valid_params) do
        {
          game_developer: {
            email: "developer@example.com",
            password: "password123",
            password_confirmation: "password123",
            studio_name: "Awesome Studio"
          }
        }
      end

      it "should create a new user" do
        post "/api/v1/game_developers", params: valid_params

        expect(response).to have_http_status(:created)

        json = JSON.parse(response.body)
        expect(json["studio_name"]).to eq("Awesome Studio")
        expect(json["token"]).to be_present
      end
    end

    context "with invalid params" do
      let(:invalid_params) do
        {
          game_developer: {
            email: "",
            password: "",
            password_confirmation: "",
            studio_name: ""
          }
        }
      end

      it "should not create a new user" do
        post "/api/v1/game_developers", params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)

        json = JSON.parse(response.body)
        expect(json["errors"]).to include("Email can't be blank")
      end
    end
  end
end
