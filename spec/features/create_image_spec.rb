require 'rails_helper'
describe 'the create_image process', type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:category) { FactoryBot.create(:category_with_six_images) }

  scenario 'Create new image' do
    login_as user, scope: :user
    # visit "/en/categories/#{ category.slug }"
    visit category_path(id: category.id)
    find('.img-thumbnail').click
    expect(page).to have_css('.modal-dialog')
    fill_in 'image[name]', with: 'Image_name'
    attach_file('image[file]', File.absolute_path(Rails.root + 'spec/factories/image.jpeg'))
    click_button('Create image')
    expect { sleep(2) }.to change(Image, :count).by(1)
  end
end