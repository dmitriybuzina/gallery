require 'rails_helper'

RSpec.describe Comment, :type => :model do
  describe 'Validation' do
    it 'is not valid without body' do
      expect(FactoryBot.build :comment, body: nil).not_to be_valid
    end
  end

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
    let(:category) { FactoryBot.create(:category_with_three_images) }
    before do
      @comment = FactoryBot.create(:comment, image: category.images.first)
    end

    it 'increment category counter' do
      expect { category.reload }.to change { category.counter }.by(1)
    end

    it 'decrement category counter' do
      category.reload
      @comment.destroy
      expect { category.reload }.to change { category.counter }.by(-1)
    end
  end
end