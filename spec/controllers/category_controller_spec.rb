require 'rails_helper'

RSpec.describe CategoriesController do
  let(:user) { FactoryBot.create(:user) }
  let(:category) { FactoryBot.create(:category) }
  let(:category_params) { FactoryBot.attributes_for(:category).stringify_keys }
  before do
    sign_in user
  end
  describe 'GET index' do
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

  describe 'GET new' do
    it 'has a 200 status code' do
      get :new
      expect(response.status).to eq(200)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'POST create' do
    it 'after create redirect to category index' do
      post :create, params: { category: FactoryBot.attributes_for(:category) }
      expect(response).to redirect_to(categories_path)
    end

    it 'create category' do
      post :create, params: { category: FactoryBot.attributes_for(:category) }
      expect(Category.count).to eq(1)
    end
  end

  describe 'PUT update' do
    before do
      put :update, params: { id: category.id, category: category_params }
    end
    it 'has a 200 status code' do
      expect(response.status).to eq(200)
    end
    it 'assigns @category' do
      expect(assigns(:category)).to eq(category)
    end
    it 'after update redirect to category show' do
      @category = FactoryBot.create(:category, name: 'Category_name')
      put :update, params: { id: @category.id, category: category_params }
      expect(response).to redirect_to @category
    end
  end

  describe 'DELETE destroy' do
    before do
      @category = FactoryBot.create(:category)
    end
    it 'destroys the requested select_option' do
      expect { delete :destroy, params: { id: category.id } }.to change(Category, :count).by(-1)
    end
    it 'after delete redirect to categories index' do
      delete :destroy, params: { id: category.id }
      expect(response).to redirect_to categories_path
    end
  end

  describe 'PUT new_folower' do
    before do
      put :new_folower, params: { id: category.id }
    end
    it 'has a 200 status code' do
      expect(response.status).to eq(200)
    end
  end
end