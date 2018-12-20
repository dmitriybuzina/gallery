require 'rails_helper'

RSpec.describe 'categories/show', :type => :view do
  let(:user) { FactoryBot.create(:user) }
  let(:image) { FactoryBot.create(:image_with_comments) }
  let(:like) { FactoryBot.create(:like, image_id: image.id, user_id: user.id) }
  before do
    login_as user, scope: :user
    image
    # visit "/en/categories/#{ image.category_id }/images/#{image.id}"
    visit category_image_path(category_id: image.category_id, id: image.id)
  end

  context 'have link to like or dislike' do
    it 'have link to like' do
      expect(page).to have_xpath "//a[contains(@href,'new_like') and contains(@data-method, 'post')]"
    end

    it 'have link to dislike' do
      like
      visit category_image_path(category_id: image.category_id, id: image.id)
      expect(page).to have_xpath "//a[contains(@href,'delete_like') and contains(@data-method, 'delete')]"
    end
  end

  it 'infers the controller action' do
    expect(controller.request.path_parameters[:action]).to eq('show')
  end

  it 'renders form for new comment' do
    expect(page).to render_template('comments/_form')
  end

end