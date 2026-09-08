require 'rails_helper'

RSpec.describe "GameTesters", type: :request do
  describe "GET /index" do
    it "returns http success" do
      # get "/game_tester/index"
      # expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      # get "/game_tester/show"
      # expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    context "with valid params" do
      let(:valid_params) do
        {
          signup_payload: {
            email: "tester@example.com",
            password: "password123",
            password_confirmation: "password123",
            birthdate: 20.years.ago.to_date
          }
        }
      end

      it "should create a new user" do
        post "/api/v1/game_testers", params: valid_params

        expect(response).to have_http_status(:created)

        json = JSON.parse(response.body)
        expect(json["user_id"]).to be_present
        expect(json["token"]).to be_present
      end
    end

    context "with invalid params" do
      let(:invalid_params) do
        {
          signup_payload: {
            email: "",
            password: "",
            password_confirmation: "",
            birthdate: ""
          }
        }
      end

      it "should not create a new user" do
        post "/api/v1/game_testers", params: invalid_params

        expect(response).to have_http_status(:unprocessable_content)

        json = JSON.parse(response.body)
        expect(json["errors"]).to include("Email can't be blank")
      end
    end
  end

  describe "GET /update" do
    it "returns http success" do
      # get "/game_tester/update"
      # expect(response).to have_http_status(:success)
    end
  end

  describe "GET /delete" do
    it "returns http success" do
      # get "/game_tester/delete"
      # expect(response).to have_http_status(:success)
    end
  end
end
