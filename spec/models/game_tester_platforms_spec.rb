require 'rails_helper'

RSpec.describe GameTesterPlatform, type: :model do
  it "is valid with a tester and a platform" do
    game_tester = create(:game_tester)
    platform = create(:platform)

    game_tester_platform = GameTesterPlatform.new(
      game_tester: game_tester,
      platform: platform
    )

    expect(game_tester_platform).to be_valid
  end
end
