require 'rails_helper'

RSpec.describe GameTester, type: :model do
  context 'is valid' do
    subject(:valid_game_tester) { build(:game_tester) }

    context 'with a specified gender value' do
      it { is_expected.to be_valid }
    end
    context 'with a specified age of the allowed age range' do
      it { is_expected.to be_valid }
    end
    context 'with a password longer than 8 characters' do
      it { is_expected.to be_valid }
    end
  end

  context 'is invalid' do
    context 'without an email' do
      subject { build(:game_tester, email: nil) }
      it { is_expected.to be_invalid }
    end
    context 'when email format is wrong' do
      subject { build(:game_tester, email: 'not a mail') }
      it { is_expected.to be_invalid }
    end
    context 'when an email already exists' do
      let!(:existing_user) { create(:game_tester, email: 'user@test.de') }
      subject { build(:game_tester, email: existing_user.email) }
      it { is_expected.to be_invalid }
    end
    context 'without a password' do
      subject { build(:game_tester, password: nil) }
      it { is_expected.to be_invalid }
    end
    context 'with a password shorter than 8 characters' do
      subject { build(:game_tester, password: '1234567') }
      it { is_expected.to be_invalid }
    end
    context 'without a specified gender value' do
      subject { build(:game_tester, gender: nil) }
      it { is_expected.to be_invalid }
    end
    context 'without a specified age' do
      subject { build(:game_tester, age: nil) }
      it { is_expected.to be_invalid }
    end
    context 'when age is below allowed range' do
      subject { build(:game_tester, age: 15) }
      it { is_expected.to be_invalid }
    end
    context 'when age is above allowed range' do
      subject { build(:game_tester, age: 101) }
      it { is_expected.to be_invalid }
    end
  end

  describe '#validate_current_password' do
    subject { create(:game_tester, password: "12345678", password_confirmation: "12345678") }
    context 'with correct password' do
      it 'returns true' do
        result = subject.validate_current_password('12345678')
        expect(result).to eq(true)
        expect(subject.errors).to be_blank
      end
    end
    context 'with false password' do
      it 'returns false' do
        result = subject.validate_current_password('11111111')
        expect(result).to eq(false)
        expect(subject.errors[:current_password]).to include('is incorrect')
      end
    end
  end
end
