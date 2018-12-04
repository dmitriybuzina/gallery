require 'rails_helper'

RSpec.describe ImagesController do
  let(:user) { FactoryBot.create(:user) }
  let(:image) { FactoryBot.create(:image) }
  let(:category) { FactoryBot.create(:category) }
  let(:image_params) { FactoryBot.attributes_for(:image).stringify_keys }
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
    it 'create activity when sign_in' do
      sign_in user
      get :index
      expect(Activity.count).to eq(1)
    end
    it 'not create activity when not sign_in' do
      get :index
      expect(Activity.count).to eq(0)
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
    it 'create activity' do
      get :show, params: { category_id: image.category_id, id: image.id }
      expect(Activity.count).to eq(1)
    end
  end

  describe 'GET new' do
    before do
      sign_in user
    end
    it 'has a 200 status code' do
      get :new, params: { category_id: category.id }
      expect(response.status).to eq(200)
    end
    it 'renders the new template' do
      get :new, params: { category_id: category.id }
      expect(response).to render_template('new')
    end
  end

  describe 'POST create' do
    let(:category) { FactoryBot.create(:category) }
    let(:image) { FactoryBot.build(:image, category: category) }
    before do
      sign_in user
      post :create,
           params: {
               category_id: category.id,
               image: {
                   name: image.name,
                   file: fixture_file_upload('spec/factories/image.jpeg')
               }
           }
    end
    it 'create image' do
      expect(Image.count).to eq(1)
    end
    it 'after create image redirect to category_path' do
      expect(response).to redirect_to(category_path(category))
    end
  end

  describe 'POST new_like' do
    before do
      sign_in user
      post :new_like, params: { category_id: category.id, id: image.id }
    end
    it 'has a 302 status code' do
      expect(response.status).to eq(302)
    end
    it 'assigns @image' do
      expect(assigns(:image)).to eq(image)
    end
    it 'after post new like redirect to categories_image_path' do
      expect(response).to redirect_to(category_image_path)
    end
    it 'create new like' do
      expect(Like.count).to eq(1)
    end
    it 'create new activity' do
      expect(Activity.count).to eq(1)
    end
    # it 'increment category counter' do
    #   expect().to change(category.counter).by(1)
    # end
  end

  describe 'DELETE delete_like' do
    before do
      sign_in user
      @image = FactoryBot.create(:image)
      @like = FactoryBot.create(:like, image_id: @image.id)
      delete :delete_like, params: { id: @like.image_id, category_id: @image.category_id, image_id: @like.image_id, user_id: @like.user_id }
    end
    it 'has a 302 status code' do
      expect(response.status).to eq(302)
    end
    it 'assigns @image' do
      expect(assigns(:image)).to eq(@image)
    end
    it 'after delete like redirect to categories_image_path' do
      expect(response).to redirect_to(category_image_path)
    end
    it 'delete like' do
      expect(Like.count).to eq(0)
    end
    it 'create new activity' do
      expect(Activity.count).to eq(1)
    end
  end
end