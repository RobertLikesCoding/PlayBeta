require 'rails_helper'

RSpec.describe GameTester, type: :model do
  let(:valid_game_tester) { build(:game_tester, age: 16) }

  context 'is valid' do
    it 'with a specified gender value' do
      expect(valid_game_tester).to be_valid
    end
    it 'with a specified age of the allowed age range' do
      expect(valid_game_tester).to be_valid
    end
  end

  context 'is invalid' do
    it 'without a specified gender value' do
      invalid_game_tester = build(:game_tester, gender: nil)
      expect(invalid_game_tester).to be_valid
    end
    it 'without a specified age' do
      invalid_game_tester = build(:game_tester, age: nil)
      expect(invalid_game_tester).to be_invalid
    end
    it 'when age is not in allowed range' do
      invalid_game_tester = build(:game_tester, age: 15)
      expect(invalid_game_tester).to be_invalid
    end
  end
end
