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
      categories = Array.new(5) { FactoryBot.create(:category) }
      get :index
      expect(assigns(:categories)).to eq(categories)
    end

    it 'create activity' do
      get :index
      expect(Activity.count).to eq(1)
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
      images = Array.new(5) { FactoryBot.create(:image, category_id: category.id) }
      get :show, params: { id: category.id }
      expect(assigns(:images)).to eq(images)
    end

    it 'create activity' do
      get :show, params: { id: category.id }
      expect(Activity.count).to eq(1)
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
    before do
      post :create, params: { category: FactoryBot.attributes_for(:category) }
    end

    it 'has a 302 status code' do
      expect(response.status).to eq(302)
    end

    it 'after create redirect to category index' do
      expect(response).to redirect_to(categories_path)
    end

    it 'create category' do
      expect(Category.count).to eq(1)
    end
  end

  describe 'PUT update' do
    before do
      put :update, params: { id: category.id, category: category_params }
    end

    it 'has a 302 status code' do
      expect(response.status).to eq(302)
    end

    it 'after update redirect to category show' do
      category = FactoryBot.create(:category, name: 'Category_name')
      put :update, params: { id: category.id, category: category_params }
      expect(response).to redirect_to category
    end
  end

  describe 'DELETE destroy' do
    before do
      @category = FactoryBot.create(:category)
    end

    it 'destroys category' do
      expect {
        delete :destroy, params: { id: @category.id }
      }.to change(Category, :count).by(-1)
    end

    it 'after delete redirect to categories index' do
      delete :destroy, params: { id: category.id }
      expect(response).to redirect_to categories_path
    end
  end

  describe 'POST new_follower' do
    before do
      post :new_follower, params: { id: category.id }
    end

    it 'has a 302 status code' do
      expect(response.status).to eq(302)
    end

    it 'assigns @category' do
      expect(assigns(:category)).to eq(category)
    end

    it 'after post new follower redirect to categories_path' do
      expect(response).to redirect_to(categories_path)
    end

    it 'create new follower' do
      expect(Category.count).to eq(1)
    end
  end

  describe 'DELETE delete_follower' do
    before do
      post :new_follower, params: { id: category.id }
      delete :delete_follower, params: { id: category.id }
    end

    it 'has a 302 status code' do
      expect(response.status).to eq(302)
    end

    it 'assigns @category' do
      expect(assigns(:category)).to eq(category)
    end

    it 'after  delete follower redirect to categories_path' do
      expect(response).to redirect_to(categories_path)
    end

    it 'destroy follow' do
      expect(Follow.count).to eq(0)
    end
  end
end