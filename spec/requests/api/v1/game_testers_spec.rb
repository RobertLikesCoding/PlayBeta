require 'rails_helper'

RSpec.describe "GameTesters", type: :request do
  let(:user) { create(:game_tester) }

  describe "GET /index" do
    it "returns http success" do
      # get "/game_tester/index"
      # expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    context 'when authenticated' do
      it "returns http success" do
        get "/api/v1/game_testers/me", headers: authenticated_header(user)
        expect(response).to have_http_status(:success)

        current_user = JSON.parse(response.body)
        expect(current_user["id"]).to eq(user.id)
        expect(Date.parse(current_user["birthdate"])).to eq(user.birthdate)
        expect(current_user["email"]).to eq(user.email)
        expect(current_user['gender']).to eq(user.gender)
        expect(current_user["password_digest"]).to_not be_present
      end
    end

    context 'when unauthorized' do
      it 'rejects the request' do
        get "/api/v1/game_testers/me"
          expect(response).to have_http_status(:unauthorized)

          json = JSON.parse(response.body)
          expect(json["error"]).to include(/unauthorized/i)
      end
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

  describe "PATCH /update" do
    let(:existing_user) { create(:game_tester, email: 'test@mail.de') }

    context 'when authenticated' do
      it "returns http success" do
        patch "/api/v1/game_testers/me",
          headers: authenticated_header(existing_user),
          params: { game_tester: { email: 'newMail@mail.de' } }

        expect(response).to have_http_status(:success)
        existing_user.reload
        expect(existing_user.email).to eq('newMail@mail.de')
        json = JSON.parse(response.body)
        expect(json["message"]).to eq("Successfully updated user data")
      end

      it "returns unprocessable content for invalid email" do
        patch "/api/v1/game_testers/me",
          headers: authenticated_header(existing_user),
          params: { game_tester: { email: "" } }

        expect(response).to have_http_status(:unprocessable_content)

        json = JSON.parse(response.body)
        expect(json["errors"]).to include("Email can't be blank")
      end
    end

    context 'when unauthorized' do
      it "returns http unauthorized" do
        patch "/api/v1/game_testers/me",
          params: { game_tester: { email: 'newMail@mail.de' } }

        expect(response).to have_http_status(:unauthorized)
        expect(existing_user.email).not_to eq('newMail@mail.de')
        expect(existing_user.email).to eq('test@mail.de')
        json = JSON.parse(response.body)
        expect(json["error"]).to include(/unauthorized/i)
      end
    end
  end

  describe "GET /delete" do
    it "returns http success" do
      # get "/game_tester/delete"
      # expect(response).to have_http_status(:success)
    end
  end
end
