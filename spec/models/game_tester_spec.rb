require 'rails_helper'

RSpec.describe GameTester, type: :model do
  context 'is valid' do
    subject(:valid_game_tester) { build(:game_tester) }

    context 'with a valid gender value' do
      it { is_expected.to be_valid }
    end
    context 'with a birthdate above 16' do
      it { is_expected.to be_valid }
    end
    it 'with an age of exactly 16' do
      valid_age_tester = build(:game_tester, birthdate: 16.years.ago)
    expect(valid_age_tester).to be_valid
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
    context 'with an invalid gender value' do
      it { expect { build(:game_tester, gender: 'alien') }.to raise_error(ArgumentError) }
    end
    context 'without a specified birthdate' do
      subject { build(:game_tester, birthdate: nil) }
      it { is_expected.to be_invalid }
    end
    context 'when birthdate is below 16' do
      subject { build(:game_tester, birthdate: 15.years.ago) }
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
