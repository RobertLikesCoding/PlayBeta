require 'rails_helper'

RSpec.describe GameDeveloper, type: :model do
  fixtures :game_developers

  # MODEL TESTS
  it "should encrypt password" do
    game_developer = game_developers(:test_studio_one)

    expect(game_developer.authenticate("password123")).to be_truthy
  end

  it "is valid with email, password and studio_name" do
    game_developer = game_developers(:test_studio_one)
    expect(game_developer).to be_valid
  end

  it "is invalid without email" do
    game_developer = game_developers(:invalid_studio)
    expect(game_developer).to_not be_valid
  end

  it "is invalid with duplicate email" do
    duplicate = GameDeveloper.create({
      email: "studio_one@example.com",
      password_digest: "password123",
      studio_name: "Awesome Studio"
    })
    expect(duplicate).to_not be_valid
  end

  it "bio should have minimum length" do
    studio1 = game_developers(:test_studio_one)
    studio2 = game_developers(:test_studio_two)

    expect(studio1).to be_valid
    expect(studio2).to_not be_valid
  end

  it "bio shouldn't exceed limit" do
    studio1 = game_developers(:test_studio_one)
    studio1.bio = "A" * 1002

    expect(studio1).to_not be_valid
  end

  #
end
