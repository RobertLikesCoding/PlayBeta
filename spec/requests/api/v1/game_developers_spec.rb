require 'rails_helper'

RSpec.describe "Api::V1::GameDevelopers", type: :request do
  let(:user) { create(:game_developer) }
  let(:jwt_secret) { ENV['JWT_SECRET_KEY'] || 'test_jwt_secret_fallback' }
  let(:token) { JWT.encode({ user_id: user.id }, jwt_secret, "HS256") }

  describe "GET /index" do
    it "returns a list of game developers" do
      create_list(:game_developer, 2)
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
      it "returns the current user" do
        token = JWT.encode({ user_id: user.id }, jwt_secret, "HS256")
        get "/api/v1/game_developers/me", headers: { "Authorization" => "Bearer #{token}" }
        expect(response).to have_http_status(:ok)

        current_user = JSON.parse(response.body)
        expect(current_user["id"]).to eq(user.id)
        expect(current_user["bio"]).to eq(user.bio)
        expect(current_user["email"]).to eq(user.email)
        expect(current_user["password_digest"]).to_not be_present
      end
    end

    context "when unauthorized" do
      it "returns an error message" do
        get "/api/v1/game_developers/me"
        expect(response).to have_http_status(:unauthorized)

        json = JSON.parse(response.body)
        expect(json["error"]).to eq("Unauthorized access. Please log in.")
      end
    end
  end

  describe "POST /signup" do
    context "with valid params" do
      let(:valid_params) do
        {
          game_developer: {
            email: "developer@example.com",
            password: "password123",
            password_confirmation: "password123"
          }
        }
      end

      it "should create a new user" do
        post "/api/v1/game_developers", params: valid_params

        expect(response).to have_http_status(:created)

        json = JSON.parse(response.body)
        expect(json["user_id"]).to be_present
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

        expect(response).to have_http_status(:unprocessable_content)

        json = JSON.parse(response.body)
        expect(json["errors"]).to include("Email can't be blank")
      end
    end
  end

  describe "POST /update" do
    let(:update_params) do
      {
        game_developer: {
          studio_name: "cool games"
        }
      }
    end
    let(:invalid_params) do
        {
          game_developer: {
            email: ""
          }
        }
      end

    it "should respond with error message if current_user is not found" do
      patch "/api/v1/game_developers/me"

      expect(response).to have_http_status(:not_found)
      json = JSON.parse(response.body)
      expect(json["error"]).to eq("User not found")
    end

    it "should update user" do
      patch "/api/v1/game_developers/me",
        params: update_params,
        headers: { "Authorization" => "Bearer #{token}" }

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["message"]).to eq("Successfully updated user data")
    end

    it "responds with errors if the update fails" do
      patch "/api/v1/game_developers/me",
        params: invalid_params,
        headers: { "Authorization" => "Bearer #{token}" }

      expect(response).to have_http_status(:unprocessable_content)
      json = JSON.parse(response.body)
      expect(json["errors"]).to include("Email can't be blank")
    end
  end
end
