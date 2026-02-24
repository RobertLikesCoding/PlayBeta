require 'rails_helper'

RSpec.describe "Passwords", type: :request do
  describe "PATCH /api/v1/passwords/update" do
    let(:game_developer) { create(:game_developer) }

    context 'if current password is wrong' do
      it "returns status unauthorized with an error message" do
        patch "/api/v1/passwords/update", params: {
          password_changes: {
            current_password: 'falsePassword',
            new_password: 'newPassword',
            new_password_confirmation: 'newPassword'
          }
        }, headers: authenticated_header(game_developer)

        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)["errors"]).to include("Current password is incorrect")
      end
    end

    context 'if current password is correct' do
      it 'updates the new password' do
        patch "/api/v1/passwords/update", params: {
          password_changes: {
            current_password: game_developer.password,
            new_password: 'newPassword',
            new_password_confirmation: 'newPassword'
          }
        }, headers: authenticated_header(game_developer)

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["message"]).to include("Successfully changed the password")
      end
    end

    context 'if the wrong data is passed' do
      it 'returns status unprocessable content' do
        patch "/api/v1/passwords/update", params: {
          password_changes: {
            current_password: game_developer.password,
            new_password: '123456',
            new_password_confirmation: '111111'
          }
        }, headers: authenticated_header(game_developer)

        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end
end
