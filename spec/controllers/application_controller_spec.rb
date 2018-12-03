require 'rails_helper'

RSpec.describe ApplicationController do
  let(:category) { FactoryBot.create(:category) }
  let(:image) { FactoryBot.create(:image) }
  describe 'Top categories' do
    it 'assign @top_categories' do
      categories = Array.new
      n = 10
      10.times do
        categories << FactoryBot.create(:category, name: "Category#{n}")
        n.times do
          FactoryBot.create(:image, category_id: :category.id)
        end
      end
    end
  end
end