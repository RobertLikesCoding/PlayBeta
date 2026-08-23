require 'rails_helper'

RSpec.describe Platform, type: :model do
  context 'with supported platform name' do
    subject { build(:platform) }
    it { is_expected.to be_valid }
  end

  context 'with duplicate name' do
    let!(:linux_platform) { create(:platform, name: 'linux') }
    subject { build(:platform, name: linux_platform.name) }
    it { is_expected.to be_invalid }
  end
  context 'with non supported platform' do
    subject { build(:platform, name: 'not a platform') }
    it { is_expected.to be_invalid }
  end
  context 'without a name' do
    subject { build(:platform, name: '') }
    it { is_expected.to be_invalid }
  end
end
