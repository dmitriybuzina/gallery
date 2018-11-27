require 'rails_helper'

RSpec.describe Activity, :type => :model do
  it 'is valid without action' do
    expect(FactoryBot.build :activity, action: nil).to be_valid
  end

  it 'is valid without url' do
    expect(FactoryBot.build :activity, url: nil).to be_valid
  end

  describe 'Association' do
    it 'belongs to user' do
      assc = described_class.reflect_on_association(:user)
      expect(assc.macro).to eq :belongs_to
    end
  end
end
