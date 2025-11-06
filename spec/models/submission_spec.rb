require 'rails_helper'

RSpec.describe Submission, type: :model do
  subject(:submission) { build(:submission) }

  describe "status" do
  it "sets default when no status is passed" do
    expect(submission.status).to eq("in_review")
  end
end

  describe 'custom validations' do
    it 'adds errors for invalid platforms' do
      submission.update(platforms: [ 'xbox', 'gameboy', 'linux' ])
      expect(submission).to be_invalid
      expect(submission.errors.full_messages).to include("Platforms contains invalid values: xbox, gameboy")
    end

    it 'adds errors for invalid genres' do
      submission.update(genre: [ 'pop', 'action', 'metal' ])
      expect(submission).to be_invalid
      expect(submission.errors.full_messages).to include("Genre contains invalid values: pop, metal")
    end
  end
end
