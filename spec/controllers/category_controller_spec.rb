require 'rails_helper'

RSpec.describe CategoriesController do
  let(:user) { FactoryBot.create(:user) }
  let(:category) { FactoryBot.create(:category) }

  describe 'GET index' do
    before do
      sign_in user
    end
    it 'has a 200 status code' do
      get :index
      expect(response.status).to eq(200)
    end
    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
    it 'assigns the @categories' do
      categories = Array.new
      5.times do
        categories << FactoryBot.create(:category)
      end
      get :index
      expect(assigns(:categories)).to eq(categories)
    end
  end

  describe 'GET show' do
    before do
      sign_in user
    end
    it 'has a 200 status code' do
      get :show, params: { id: category.id }
      expect(response.status).to eq(200)
    end
    it 'renders the show template' do
      get :show, params: { id: category.id }
      expect(response).to render_template('show')
    end
    it 'assigns the @category' do
      get :show, params: { id: category.id }
      expect(assigns(:category)).to eq(category)
    end
    it 'assigns the @images' do
      images = Array.new
      5.times do
        images << FactoryBot.create(:image, category_id: category.id)
      end
      get :show, params: { id: category.id }
      expect(assigns(:images)).to eq(images)
    end
  end

  # describe 'POST create' do
  #   it 'create category' do
  #     # category = FactoryBot.build(:category)
  #     post :create, category: FactoryBot.build(:category).attributes
  #     expect(Category.count).to eq(1)
  #   end
  # end
end