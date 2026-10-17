require 'rails_helper'

RSpec.describe Submission, type: :model do
  subject(:healthy_submission) { create(:submission) }

  context 'is valid' do
    context 'with valid attributes' do
      it { is_expected.to be_valid }
    end

    it 'with 100 character title' do
      healthy_submission.title = 'a' * 100
      expect(healthy_submission).to be_valid
    end
  end

  context 'is invalid' do
    it "with missing title" do
      healthy_submission.title = ''
      expect(healthy_submission).not_to be_valid
    end

    it "with title of 101 characters" do
      healthy_submission.title = 'a' * 101
      expect(healthy_submission).not_to be_valid
    end

    it "when s_id already exists" do
      uuid = SecureRandom.uuid
      create(:submission, s_id: uuid)
      healthy_submission.s_id = uuid

      expect(healthy_submission).not_to be_valid
    end
    it "with description missing" do
      healthy_submission.description = nil
      expect(healthy_submission).not_to be_valid
    end
    it "with description longer than 1000 characters" do
      healthy_submission.description = '1'
      100.times do
        healthy_submission.description << "1234567890"
      end
      expect(healthy_submission).not_to be_valid
    end
    it "with genres missing" do
      healthy_submission.genres = []
      expect(healthy_submission).not_to be_valid
    end
    it "with platforms missing" do
      healthy_submission.platforms = []
      expect(healthy_submission).not_to be_valid
    end
    it "with demo_url missing" do
      healthy_submission.demo_url = nil
      expect(healthy_submission).not_to be_valid
    end
    it "when the demo_url does not start with https://" do
      healthy_submission.demo_url = 'http://'
      expect(healthy_submission).not_to be_valid
    end
    it "when version is missing" do
      healthy_submission.version = nil
      expect(healthy_submission).not_to be_valid
    end
    it "with invalid status" do
      healthy_submission.status = 'made up status'
      expect(healthy_submission).not_to be_valid
    end
  end


  describe "status" do
    it "sets default when no status is passed" do
      expect(healthy_submission.status).to eq("in_review")
    end
  end

  context 'before validation' do
    let(:new_submission) { build(:submission) }

    it 'automatically assigns a s_id ' do
      expect(new_submission.s_id).to be_blank

      new_submission.valid?
      expect(new_submission.s_id).not_to be_blank
    end
  end

  describe "dependent destroy" do
    it "destroys invitations when the submission is destroyed" do
      submission = create(:submission)
      game_tester = create(:game_tester)
      invitation = create(:invitation, submission:, game_tester:)

      expect { submission.destroy }
        .to change { Invitation.exists?(invitation.id) }
        .from(true).to(false)

      expect(GameTester.exists?(game_tester.id)).to be(true)
    end
  end

  describe "invitations" do
    let(:game_tester) { create(:game_tester) }
    it "has many game_testers through invitations" do
      submission = create(:submission)
      create(:invitation, game_tester:, submission:)

      expect(submission.game_testers).to include(game_tester)
    end
  end
end
