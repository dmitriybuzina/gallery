require 'rails_helper'

RSpec.describe ApplicationController do


  describe 'Top categories' do
    before do
      @categories = Array.new
      n = 10
      10.times do
        @categories << FactoryBot.create(:category, name: "Category#{n}")
        n.times do
          FactoryBot.create(:image, category_id: @categories.last.id)
        end
        n -= 1
      end
      @categories.sort_by { |category| category.counter }
    end
    it 'limit to 5 categories' do
      expect(subject.top_categories.length).to eq(5)
    end
    it 'assign @top categories' do

    end
  end
end