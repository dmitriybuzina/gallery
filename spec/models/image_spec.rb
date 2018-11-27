require 'rails_helper'

RSpec.describe Image, :type => :model do
  subject(:image){ FactoryBot.create(:image) }
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
  end

end