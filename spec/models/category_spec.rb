require 'rails_helper'

RSpec.describe Category, :type => :model do

  subject(:category){ FactoryBot.create(:category) }
  it 'is valid with valid attributes' do
    expect(Category.new).not_to be_valid
  end
  it 'is valid without user_id' do
    expect(FactoryBot.build :category, user_id: nil).not_to be_valid
  end

  it 'is valid without name'
  it 'is not valid without counter' do
    expect(FactoryBot.build :category, counter: nil).to be_valid
  end
end