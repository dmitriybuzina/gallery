require 'rails_helper'

RSpec.describe ImagesController do
  let(:user) { FactoryBot.create(:user) }
  let(:image) { FactoryBot.create(:image) }
  describe 'GET index' do
    it 'has a 200 status code' do
      get :index
      expect(response.status).to eq(200)
    end
    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
    it 'assigns the @images' do
      images = Array.new
      5.times do
        images << FactoryBot.create(:image)
      end
      get :index
      expect(assigns(:images)).to eq(images)
    end
  end

  describe 'GET show' do
    before do
      sign_in user
    end
    it 'has a 200 status code' do
      get :show, params: { category_id: image.category_id, id: image.id }
      expect(response.status).to eq(200)
    end
    it 'renders the show template' do
      get :show, params: { category_id: image.category_id, id: image.id }
      expect(response).to render_template('show')
    end
    it 'assigns the @image' do
      get :show, params: { category_id: image.category_id, id: image.id }
      expect(assigns(:image)).to eq(image)
    end
    it 'assigns the @comments' do
      comments = Array.new
      5.times do
        comments << FactoryBot.create(:comment, image_id: image.id)
      end
      get :show, params: { category_id: image.category_id, id: image.id }
      expect(assigns(:comments)).to eq(comments.sort_by { |comment| comment['created_at'] }.reverse)
    end
  end

  describe 'POST create' do
    it 'create image' do
      image_attributes = FactoryBot.create(:image).attributes
      post :create, image: image_attributes
      expect(Image.count).to eq(1)
    end
  end
end