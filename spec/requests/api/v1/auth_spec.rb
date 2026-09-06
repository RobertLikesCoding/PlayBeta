require 'rails_helper'

RSpec.describe "Api::V1::Auths", type: :request do
  let(:developer) { create(:game_developer) }
  let(:tester) { create(:game_tester) }
  let(:invalid_token) { "invalid.token.here" }

  describe "POST /developer_login" do
    context "with valid credentials" do
      let(:valid_params) do
        {
          auth: {
            email: developer.email,
            password: developer.password
          }
        }
      end

      it "authenticates a game_developer and returns a token" do
        post "/api/v1/auth/developer_login", params: valid_params

        expect(response).to have_http_status(:accepted)
      end
    end

    context "with invalid credentials" do
      let(:invalid_params) do
        {
          auth: {
            email: developer.email,
            password: ""
          }
        }
      end

      it "does not authenticate a game_developer" do
        post "/api/v1/auth/developer_login", params: invalid_params

        expect(response).to have_http_status(:unauthorized)
      end

      it "does not authenticate a game_tester" do
        post "/api/v1/auth/tester_login", params: invalid_params

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
  describe "POST /tester_login" do
    context "with valid credentials" do
      let(:valid_params) do
        {
          auth: {
            email: tester.email,
            password: tester.password
          }
        }
      end

      it "authenticates a game_tester and returns a token" do
        post "/api/v1/auth/tester_login", params: valid_params

        expect(response).to have_http_status(:accepted)
      end
    end

    context "with invalid credentials" do
      let(:invalid_params) do
        {
          auth: {
            email: tester.email,
            password: ""
          }
        }
      end

      it "does not authenticate a game_tester" do
        post "/api/v1/auth/tester_login", params: invalid_params

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "JWT Decode Error Logging" do
    it "logs an error when decoding an invalid token" do
      # Mock the logger
      allow(Rails.logger).to receive(:error)

      # Set an invalid Authorization header
      headers = { "Authorization" => "Bearer #{invalid_token}" }
      get "/api/v1/game_developers/me", headers: headers

      # Verify that Rails.logger.error was called with the expected message
      expect(Rails.logger).to have_received(:error).with(/JWT Decode Error: /)
    end
  end
end
