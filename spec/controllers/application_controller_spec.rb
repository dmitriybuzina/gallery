require 'rails_helper'

RSpec.describe ApplicationController do
  describe 'Top categories' do
    let(:category) { FactoryBot.create(:category_with_images) }

    controller do
      def index; end
    end

    before do
      get :index, format: 'text/html'
    end

    it 'assign @top categories' do
      expect(assigns(:top_categories)).to eq(Category.order('counter DESC').limit(5))
    end
  end
end