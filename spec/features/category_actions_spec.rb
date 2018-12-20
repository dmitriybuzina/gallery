require 'rails_helper'

RSpec.describe 'features/categories_actions',type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:categories) { FactoryBot.create_list(:category, 6) }
  before do
    login_as user, scope: :user
    categories
    visit '/en/categories/'
  end

  scenario 'Create new category' do
    find('#button_category').click
    expect(page).to have_css('.modal-dialog')
    fill_in 'category[name]', with: 'Category_name'
    expect { click_button('Create category') }.to change(Category, :count).by(1)
    # find_button('Create category').click
    # expect(Category.count).to eq(7)
  end

  scenario 'Edit category' do
    first('.container-category').hover
    first(:xpath, "//a[contains(@href,'edit') and contains(@href,'categories')]").click
    expect(page).to have_content('Editing Category')
    fill_in 'category[name]', with: 'Other_category_name'
    find_button('Create category').click
  end

  scenario 'Delete category' do
    first('.container-category').hover
    expect { first(:xpath, "//a[contains(@data-method,'delete')]").click }.to change(Category, :count).by(-1)
    expect(current_path).to eq('/en/categories')
  end

  scenario 'Follow category' do
    first('.container-category').hover
    first(:xpath, "//a[contains(@href,'new_follower')]").click
    expect(current_path).to eq('/en/categories/')
    expect(Follow.count).to eq(1)
  end
end