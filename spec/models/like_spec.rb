require 'rails_helper'

RSpec.describe Like, :type => :model do
  describe 'Associations' do
    it 'belongs to image' do
      assc = described_class.reflect_on_association(:image)
      expect(assc.macro).to eq :belongs_to
    end

    it 'belongs to user' do
      assc = described_class.reflect_on_association(:user)
      expect(assc.macro).to eq :belongs_to
    end
  end

  describe 'Methods' do
    let(:category) { FactoryBot.create(:category_with_six_images) }
    let(:image) { FactoryBot.create(:image, category: category) }
    before do
      @like = FactoryBot.create(:like, image: image)
    end

    it 'increment category counter' do
      expect { category.reload }.to change { category.counter }.by(1)
    end

    it 'decrement category counter' do
      category.reload
      @like.destroy
      expect { category.reload }.to change { category.counter }.by(-1)
    end

    it 'increment count of likes' do
      expect { image.reload }.to change { image.count_likes }.by(1)
    end

    it 'decrement count of likes' do
      image.reload
      @like.destroy
      expect { image.reload }.to change { image.count_likes }.by(-1)
    end
  end
end