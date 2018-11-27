require 'rails_helper'

RSpec.describe User, :type => :model do
  it 'is valid without phone' do
    expect(FactoryBot.build :user, phone: nil).to be_valid
  end

  it 'is valid without date_of_birthday' do
    expect(FactoryBot.build :user, date_of_birthday: nil).to be_valid
  end

  it 'is valid without location' do
    expect(FactoryBot.build :user, location: nil).to be_valid
  end

  it 'is valid without avatar' do
    expect(FactoryBot.build :user, avatar: nil).to be_valid
  end

  it 'is valid without provider' do
    expect(FactoryBot.build :user, provider: nil).to be_valid
  end

  it 'is valid without uid' do
    expect(FactoryBot.build :user, uid: nil).to be_valid
  end

  describe 'Associations' do
    it 'has many activities' do
      assc = described_class.reflect_on_association(:activities)
      expect(assc.macro).to eq :has_many
    end

    it 'has many categories' do
      assc = described_class.reflect_on_association(:categories)
      expect(assc.macro).to eq :has_many
    end

    it 'has many comments' do
      assc = described_class.reflect_on_association(:comments)
      expect(assc.macro).to eq :has_many
    end

    it 'has many likes' do
      assc = described_class.reflect_on_association(:likes)
      expect(assc.macro).to eq :has_many
    end
  end
end
