require 'rails_helper'

RSpec.describe User, :type => :model do
  describe 'Validation' do
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
  end

  describe 'Associations' do
    let(:user) { FactoryBot.create(:user) }
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

    it 'destroy activities when destroy user' do
      5.times { FactoryBot.create(:activity, user_id: user.id) }
      expect { user.destroy }.to change { Activity.count }.by(-5)
    end

    it 'destroy categories when destroy user' do
      5.times { FactoryBot.create(:category, user_id: user.id) }
      expect { user.destroy }.to change { Category.count }.by(-5)
    end

    it 'destroy comments when destroy user' do
      5.times { FactoryBot.create(:comment, user_id: user.id) }
      expect { user.destroy }.to change { Comment.count }.by(-5)
    end

    it 'destroy likes when destroy user' do
      5.times { FactoryBot.create(:like, user_id: user.id) }
      expect { user.destroy }.to change { Like.count }.by(-5)
    end

    it 'destroy follows when destroy user' do
      5.times { FactoryBot.create(:follow, user_id: user.id) }
      expect { user.destroy }.to change { Follow.count }.by(-5)
    end



  end
end
