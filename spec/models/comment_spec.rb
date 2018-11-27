require 'rails_helper'

RSpec.describe Comment, :type => :model do
  it 'is not valid without body' do
    expect(FactoryBot.build :comment, body: nil).not_to be_valid
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

end