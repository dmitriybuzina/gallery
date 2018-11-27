require 'rails_helper'

RSpec.describe Category, :type => :model do

  subject(:category){ FactoryBot.create(:category) }
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

  describe 'Associations' do
    it 'has many images' do
      assc = described_class.reflect_on_association(:images)
      expect(assc.macro).to eq :has_many
    end

    it 'has many comments' do
      assc = described_class.reflect_on_association(:comments)
      expect(assc.macro).to eq :has_many
    end

    it 'belongs to user' do
      assc = described_class.reflect_on_association(:user)
      expect(assc.macro).to eq :belongs_to
    end

    # it 'acts as followable' do
    #   assc = described_class.reflect_on_association(:followable_type)
    #   expect(assc.macro).to eq acts_as_followable
    # end
  end


end