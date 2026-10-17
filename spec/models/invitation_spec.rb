require 'rails_helper'

RSpec.describe Invitation, type: :model do
  let(:submission) { create(:submission) }
  let(:tester) { create(:game_tester) }

  describe "validations" do
    it "is valid with submission_id and game_tester_id" do
      invitation = build(:invitation, submission: submission, game_tester: tester)

      expect(invitation).to be_valid
    end

    it "is invalid without submission and tester ids" do
      invitation = build(:invitation, submission: nil, game_tester: nil)

      expect(invitation).to be_invalid
    end

    context "when invitation already exists" do
      let!(:existing_invitation) { create(:invitation, submission: submission, game_tester: tester) }
      it "can't create the same invitation again" do
        invitation = build(:invitation, submission: submission, game_tester: tester)

      expect(invitation).to be_invalid
      end
    end

    it "is valid with valid status" do
      invitation = build(:invitation, status: 'accepted')

      expect(invitation).to be_valid
    end

    it "is invalid with invalid status" do
      invitation = build(:invitation, status: 'none')

      expect(invitation).to be_invalid
    end
  end

  describe "status" do
    it "defaults to pending status" do
      invitation = build(:invitation)

      expect(invitation.status).to eq('pending')
    end
  end
end
