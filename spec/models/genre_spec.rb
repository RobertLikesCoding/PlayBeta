require 'rails_helper'

RSpec.describe Genre, type: :model do
  context 'with supported genre name' do
    subject { build(:genre) }
    it { is_expected.to be_valid }
  end

  context 'with duplicate name' do
    let!(:action_genre) { create(:genre, name: 'action') }
    subject { build(:genre, name: action_genre.name) }
    it { is_expected.to be_invalid }
  end
  context 'with non supported genre' do
    subject { build(:genre, name: 'not a genre') }
    it { is_expected.to be_invalid }
  end
  context 'without a name' do
    subject { build(:genre, name: '') }
    it { is_expected.to be_invalid }
  end
end
