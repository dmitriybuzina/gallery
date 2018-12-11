require 'rails_helper'

RSpec.describe Category, :type => :model do
  let(:category) { FactoryBot.create(:category) }
  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(Category.new).not_to be_valid
    end

    it 'is valid without user_id' do
      expect(FactoryBot.build :category, user_id: nil).not_to be_valid
    end

    it 'is not valid without name' do
      expect(FactoryBot.build :category, name: nil).to be_valid
    end

    it 'is not valid without counter' do
      expect(FactoryBot.build :category, counter: nil).to be_valid
    end
  end

  describe 'Associations' do
    it 'has many images' do
      assc = described_class.reflect_on_association(:images)
      expect(assc.macro).to eq :has_many
    end

    it 'has many comments' do
      assc = described_class.reflect_on_association(:comments)
      expect(assc.macro).to eq :has_many
    end

    it 'has many follows' do
      assc = described_class.reflect_on_association(:follows)
      expect(assc.macro).to eq :has_many
    end

    it 'belongs to user' do
      assc = described_class.reflect_on_association(:user)
      expect(assc.macro).to eq :belongs_to
    end

    it 'destroy images when destoy category' do
      5.times { FactoryBot.create(:image, category_id: category.id) }
      expect { category.destroy }.to change { Image.count }.by(-5)
    end

    it 'destroy follows when destroy category' do
      5.times { FactoryBot.create(:follow, category_id: category.id) }
      expect { category.destroy }.to change { Follow.count }.by(-5)
    end
  end

  describe 'Methods' do
    let(:category_follow) { FactoryBot.create(:category) }
    let(:category_not_follow) { FactoryBot.create(:category) }
    let(:follow) { FactoryBot.create(:follow, category_id: category_follow.id) }

    it 'is follow user' do
      expect(category_follow.is_follow(follow.user_id)).to eq(true)
    end

    it 'is not follow user' do
      expect(category_not_follow.is_follow(follow.user_id)).to eq(false)
    end
  end
end