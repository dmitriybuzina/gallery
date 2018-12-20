require 'rails_helper'

RSpec.describe 'categories/index',:type => :view do
  let(:user) { FactoryBot.create(:user) }
  let(:categories) { FactoryBot.create_list(:category, 6) }
  before do
    login_as user, scope: :user
    categories
    visit '/en/categories/'
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


