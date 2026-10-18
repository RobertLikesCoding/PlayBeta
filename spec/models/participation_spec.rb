require 'rails_helper'

RSpec.describe Participation, type: :model do
  let(:submission) { create(:submission) }
  let(:tester) { create(:game_tester) }

  describe "validations" do
    it "is valid with submission_id and game_tester_id" do
      participation = build(:participation, submission: submission, game_tester: tester)

      expect(participation).to be_valid
    end

    it "is invalid without submission and tester ids" do
      participation = build(:participation, submission: nil, game_tester: nil)

      expect(participation).to be_invalid
    end

    context "when participation already exists" do
      let!(:existing_participation) { create(:participation, submission: submission, game_tester: tester) }
      it "can't create the same participation again" do
        participation = build(:participation, submission: submission, game_tester: tester)

      expect(participation).to be_invalid
      end
    end

    it "is valid with valid status" do
      participation = build(:participation, status: 'signed_up')

      expect(participation).to be_valid
    end

    it "is invalid with invalid status" do
      participation = build(:participation, status: 'none')

      expect(participation).to be_invalid
    end
  end

  describe "status" do
    it "defaults to signed_up status" do
      participation = build(:participation)

      expect(participation.status).to eq('signed_up')
    end
  end
end
