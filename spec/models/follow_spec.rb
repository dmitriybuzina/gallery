require 'rails_helper'

RSpec.describe Follow, :type => :model do
  describe 'Associations' do
    it 'belongs to image' do
      assc = described_class.reflect_on_association(:category)
      expect(assc.macro).to eq :belongs_to
    end

    it 'belongs to user' do
      assc = described_class.reflect_on_association(:user)
      expect(assc.macro).to eq :belongs_to
    end
  end
end