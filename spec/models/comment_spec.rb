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

  describe 'Comment' do
    before do
      @category = FactoryBot.create(:category_with_three_images)
      FactoryBot.create(:comment, image_id: @category.image.id)
    end

    it 'decrement category counter' do
      expect(@category.counter).to eq(4)
    end

    it 'increment category counter' do
      # category = Category.find_by_id((Image.find_by_id(@comment.image_id)).category_id)
      category = @comment.image.category
      puts category
      expect { @comment.destroy }.to change { category.counter }.by(-1)
    end
  end
end