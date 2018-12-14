require 'rails_helper'

RSpec.describe 'categories/index',:type => :view do
  let(:user) { FactoryBot.create(:user) }
  let(:categories) { FactoryBot.create_list(:category, 6) }
  let(:category) { FactoryBot.create(:category) }
  before do
    login_as user, scope: :user
    categories
    visit '/en/categories/'
  end

  scenario 'Create new category' do
    find('#button_category').click
    expect(page).to have_css('.modal-dialog')
    fill_in 'category[name]', with: 'Category_name'
    find_button('Create category').click
    expect(Category.count).to eq(7)
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
    first(:xpath, "//a[contains(@data-method,'delete')]").click
    expect(current_path).to eq('/en/categories')
    expect(Category.count).to eq(5)
  end

  scenario 'Follow category' do
    first('.container-category').hover
    first(:xpath, "//a[contains(@href,'new_follower')]").click
    expect(current_path).to eq('/en/categories/')
    expect(Follow.count).to eq(1)
  end

  it 'count of categories' do
    expect(page).to have_selector('.container-category', count: Category.count)
  end

  it 'renders form for new category' do
    expect(page).to render_template('categories/_form')
  end

  it 'have button to create category' do
    expect(page).to have_selector('#button_category')
  end

  it 'should have link New Category' do
    expect(page).to have_link('New Category')
  end

  it 'have modal for new category' do
    find('#button_category').click
    expect(page).to have_css('.modal-dialog')
  end

  it 'should have link Home' do
    expect(page).to have_link('Home')
  end

  it 'should have link to follow' do
    first('.container-category').hover
    expect(page).to have_xpath "//a[contains(@href,'new_follower')]"
  end

  it 'should have link to Edit category' do
    first('.container-category').hover
    expect(page).to have_xpath "//a[contains(@href,'edit')]"
  end

  it 'should have link to Delete category' do
    first('.container-category').hover
    expect(page).to have_xpath "//a[contains(@data-method,'delete')]"
  end

  it 'infers the controller action' do
    expect(controller.request.path_parameters[:action]).to eq('index')
  end

  it 'has a request.fullpath that is defined' do
    expect(controller.request.fullpath).to eq categories_path
  end
end


