require 'rails_helper'

RSpec.describe GameDeveloper, type: :model do
  it "should encrypt password" do
    game_developer = build(:game_developer, email: "test@studio.com", password: "password123")
    expect(game_developer.authenticate("password123")).to be_truthy
  end

  context 'is invalid' do
    it 'without password' do
      game_developer = build(:game_developer, password: '', password_confirmation: '')
      expect(game_developer).to_not be_valid
    end

    it 'with password shorter than 8 characters' do
      game_developer = build(:game_developer, password: '123', password_confirmation: '123')
      expect(game_developer).to_not be_valid
    end

    it "without email" do
      game_developer = build(:game_developer, :invalid)
      expect(game_developer).to_not be_valid
    end

    it "with duplicate email" do
      user = create(:game_developer)
      duplicate = GameDeveloper.build({
        email: user.email,
        password_digest: user.password_digest,
        studio_name: user.studio_name
      })

      expect(duplicate).to_not be_valid
    end

    it "with too long bio" do
      long_bio_game_developer = build(:game_developer, :long_bio)
      expect(long_bio_game_developer).to_not be_valid
    end
  end

  it "is valid with email, password and studio_name" do
    game_developer = build(:game_developer)
    expect(game_developer).to be_valid
  end
end
