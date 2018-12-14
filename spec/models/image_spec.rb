require 'rails_helper'

RSpec.describe Image, :type => :model do
  let(:image){ FactoryBot.create(:image) }
  describe 'Validation' do
    it 'is valid without name' do
      expect(FactoryBot.build :image, name: nil, file: image.file).to be_valid
    end

    it 'is not valid without category_id' do
      expect(FactoryBot.build :image, category_id: nil).not_to be_valid
    end

    it 'is not valid without file' do
      expect(FactoryBot.build :image, file: nil).not_to be_valid
    end

    it 'is valid without count_likes' do
      expect(FactoryBot.build :image, count_likes: nil).to be_valid
    end
  end

  describe 'Associations' do
    it 'has many comments' do
      assc = described_class.reflect_on_association(:comments)
      expect(assc.macro).to eq :has_many
    end

    it 'has many likes' do
      assc = described_class.reflect_on_association(:likes)
      expect(assc.macro).to eq :has_many
    end

    it 'belongs to category' do
      assc = described_class.reflect_on_association(:category)
      expect(assc.macro).to eq :belongs_to
    end

    it 'destroy comments when destroy image' do
      5.times { FactoryBot.create(:comment, image_id: image.id) }
      expect { image.destroy }.to change { Comment.count }.by(-5)
    end

    it 'destroy likes when destroy image' do
      5.times { FactoryBot.create(:like, image_id: image.id) }
      expect { image.destroy }.to change { Like.count }.by(-5)
    end
  end

  describe 'Methods' do
    let(:image_like) { FactoryBot.create(:image) }
    let(:image_not_like) { FactoryBot.create(:image) }
    let(:like) { FactoryBot.create(:like, image_id: image_like.id) }
    let(:category) { FactoryBot.create(:category_with_three_images) }
    it 'is liked user' do
      expect(image_like.is_liked(like.user_id)).to eq(true)
    end

    it 'is not liked user' do
      expect(image_not_like.is_liked(like.user_id)).to eq(false)
    end

    it 'category counter cache' do
      expect(category.counter).to eq(3)
    end

    it 'increment category counter cache' do
      expect { FactoryBot.create(:image, category: category) }.to change { category.counter }.by(1)
    end

    it 'decrement category counter cache' do
      expect { category.images.first.destroy }.to change { category.counter }.by(-1)
    end
  end

end