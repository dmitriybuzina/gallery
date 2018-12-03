require 'rails_helper'

RSpec.describe CommentsController do
  let(:user) { FactoryBot.create(:user) }
  let(:image) { FactoryBot.create(:image) }
  let(:category) { FactoryBot.create(:category) }
  let(:comment) { FactoryBot.create[:comment, image_id: image.id] }
  before do
    sign_in user
  end
  describe 'GET index' do
    before do
      get :index, params: { category_id: image.category_id, image_id: image.id }
    end
    it 'has a 200 status code' do
      expect(response.status).to eq(200)
    end
    it 'renders the index template' do
      expect(response).to render_template('index')
    end
    it 'assigns the @image' do
      expect(assigns(:image)).to eq(image)
    end
    it 'assign the @comments' do
      comments = Array.new
      5.times do
        comments << FactoryBot.create(:comment, image_id: image.id)
      end
      expect(assigns(:comments)).to eq(comments)
    end
  end

  describe 'GET new' do
    before do
      get :new, params: { category_id: image.category_id, image_id: image.id }
    end
    it 'has a 200 status code' do
      expect(response.status).to eq(200)
    end
    it 'renders the new template' do
      expect(response).to render_template('new')
    end
  end

  describe 'POST create' do
    before do
      post :create, params: { category_id: image.category_id, image_id: image.id, comment: FactoryBot.attributes_for(:comment, image_id: image.id) }
    end
    it 'has a 302 status code' do
      expect(response.status).to eq(302)
    end
    it 'after create redirect to category_image_path' do
      expect(response).to redirect_to(category_image_path(id: image.id))
    end
    it 'create comment' do
      expect(Comment.count).to eq(1)
    end
    it 'create new activity' do
      expect(Activity.count).to eq(1)
    end
  end
end