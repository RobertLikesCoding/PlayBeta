require 'rails_helper'

RSpec.describe GameDeveloper, type: :model do
  it "should encrypt password" do
    game_developer = build(:game_developer, email: "test@studio.com", password: "password123")

    expect(game_developer.authenticate("password123")).to be_truthy
  end

  it "is valid with email, password and studio_name" do
    game_developer = build(:game_developer)
    expect(game_developer).to be_valid
  end

  it "is invalid without email" do
    game_developer = build(:game_developer, :invalid)
    expect(game_developer).to_not be_valid
  end

  it "is invalid with duplicate email" do
    user = create(:game_developer)
    duplicate = GameDeveloper.build({
      email: user.email,
      password_digest: user.password_digest,
      studio_name: user.studio_name
    })

    expect(duplicate).to_not be_valid
  end

  it "bio shouldn't exceed limit" do
    long_bio_game_developer = build(:game_developer, :long_bio)
    expect(long_bio_game_developer).to_not be_valid
  end

  #
end
