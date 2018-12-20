require 'rails_helper'

RSpec.describe 'categories/show', :type => :view do
  let(:user) { FactoryBot.create(:user) }
  let(:category) { FactoryBot.create(:category_with_six_images) }
  before do
    login_as user, scope: :user
    category
    assign(:category, category)
    assign(:images, category.images)
    visit category_path(id: category.id)
  end

  it 'have modal for new category' do
    # find('#image_modal').click
    expect(page).to have_xpath "//div[contains(@data-target,'image_modal')]"
  end

  it 'have pagination' do
    expect(page).to have_css('.pagination')
  end

  it 'have only 5 images' do
    expect(page).to have_xpath("//a[contains(@href,'/categories/#{category.slug}/images')]", count: 5)
  end

  it 'renders form for new image' do
    expect(page).to render_template('images/_form')
  end

  it 'infers the controller action' do
    expect(controller.request.path_parameters[:action]).to eq('show')
  end

  # it 'has a request.fullpath that is defined' do
  #   expect(controller.request.fullpath).to eq category_path(category)
  # end
end