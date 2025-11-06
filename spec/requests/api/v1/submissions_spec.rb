require 'rails_helper'

RSpec.describe "Api::V1::Submissions", type: :request do
  let(:game_developer) { create(:game_developer) }
  let(:jwt_secret) { ENV['JWT_SECRET_KEY'] || 'test_jwt_secret_fallback' }
  let(:token) { JWT.encode({ user_id: game_developer.id }, jwt_secret, "HS256") }
  let(:headers) { { "Authorization" => "Bearer #{token}" } }
  let!(:submission) { create(:submission, game_developer: game_developer) }

  describe "GET /index" do
    before { create_list(:submission, 3, game_developer:) }

    it "should return all submissions for the current user" do
      get "/api/v1/submissions", headers: headers

      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["message"]).to include("Successfully loaded submissions of")
      expect(json["submissions"].size).to eq(4)
    end
  end

  describe "GET /show" do
    it "should return a submission" do
      get "/api/v1/submissions/#{submission.s_id}", headers: headers
      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)
      expect(json["message"]).to include("Successfully loaded submission")
      expect(json["submission"]["s_id"]).to eq(submission.s_id)
    end
  end

  describe "POST /create" do
    it "should create a new submission" do
      submission_params = attributes_for(:submission)

      post "/api/v1/submissions",
        headers: headers,
        params: { submission: submission_params }

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["message"]).to eq("Successfully created new submission")
    end

    it "should render error when create fails" do
      submission_params = { title: "" }

      post "/api/v1/submissions",
        headers: headers,
        params: { submission: submission_params }

      expect(response).to have_http_status(:unprocessable_content)
      json = JSON.parse(response.body)
      expect(json["message"]).to eq("Failed to create submission")
    end
  end

  describe "PATCH /update" do
    it "should update a submission" do
      submission_params = { title: 'A new title' }

      patch "/api/v1/submissions/#{submission.s_id}", headers: headers, params: { submission: submission_params }

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["message"]).to eq("Successfully updated submission")
      expect(json["submission"]["title"]).to eq("A new title")
    end

    it "should render error when update fails" do
      submission_params = { title: '' }

      patch "/api/v1/submissions/#{submission.s_id}", headers: headers, params: { submission: submission_params }

      expect(response).to have_http_status(:unprocessable_content)
      json = JSON.parse(response.body)
      expect(json["message"]).to eq("Failed to update submission")
    end
  end

  describe "DELETE /destroy" do
    it "should delete a submission" do
      new_submission = create(:submission, game_developer: game_developer)

      delete "/api/v1/submissions/#{new_submission.s_id}", headers: headers

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["message"]).to eq("Successfully deleted submission")
      expect(Submission.exists?(new_submission.id)).to be_falsey
    end

    it "should render error message when deletion fails" do
      new_submission = create(:submission, game_developer: game_developer)
      allow_any_instance_of(Submission).to receive(:destroy).and_return(false)

      delete "/api/v1/submissions/#{new_submission.s_id}", headers: headers

      expect(response).to have_http_status(:unprocessable_content)
      json = JSON.parse(response.body)
      expect(json["message"]).to eq("Deletion of submission failed")
    end
  end

  describe "GET /constants" do
    it "returns constants for platforms and genres" do
      get "/api/v1/submissions/constants"

      data = JSON.parse(response.body)
      expect(data["genres"]).to eq(SUBMISSION_CONSTANTS[:genres])
      expect(data["platforms"]).to eq(SUBMISSION_CONSTANTS[:platforms])
    end
  end
end
