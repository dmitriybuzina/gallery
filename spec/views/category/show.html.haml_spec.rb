require 'rails_helper'

RSpec.describe 'categories/show', :type => :view do
  let(:user) { FactoryBot.create(:user) }
  let(:category) { FactoryBot.create(:category) }
  let(:images) { FactoryBot.create_list(:image, 6, category_id: category.id) }
  # let(:category) { FactoryBot.create(:category_with_images, name: 'CategoryName') }
  before do
    login_as user, scope: :user
    images
    assign(:category, category)
    assign(:images, category.images)
    visit "/en/categories/#{ category.id }/"
  end

  it 'have modal for new category' do
    # find('#image_modal').click
    expect(page).to have_xpath "//div[contains(@data-target,'image_modal')]"
  end

  it 'have pagination' do
    expect(page).to have_css('.pagination')
  end

  it 'have only 5 images' do
    expect(page).to have_xpath("//a[contains(@href,'/categories/#{category.name}/images')]", count: 5)
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

  scenario 'Create new image' do
    puts category.id
    puts current_path
    puts Category.count
    find('.img-thumbnail').click
    expect(page).to have_css('.modal-dialog')
    fill_in 'image[name]', with: 'Image_name'
    attach_file('image[file]', File.absolute_path(Rails.root + 'spec/factories/image.jpeg'))
    puts current_path
    expect { click_button('Create image') }.to change(Image, :count).by(1)
  end
end