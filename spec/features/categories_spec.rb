require 'rails_helper'

describe 'on the index page',:type => :view do
  before(:each) do
    login_as(FactoryBot.create(:user), scope: :user)
    @categories = []
    6.times{ @categories << FactoryBot.create(:category) }
    visit '/en/categories/'
  end
  it 'should list the categories name' do
    @categories.each do |category|
      expect(page).to have_text(category.name)
    end
  end
  it 'should have link New Category' do
    expect(page).to have_link('New Category')
  end
  it 'go to create category' do
    expect(page).to have_selector('body > button')
    # expect(page).to have_css('a', href: 'New Category')
  end
  it 'should have link to category' do
    @categories.each do |category|
      expect(page).to have_link(category.name)
    end
  end
  it 'should have link Home' do
    expect(page).to have_link('Home')
  end
  it 'should have category modal' do
    expect(page).to have_selector('#categories_modal')
  end
  it 'have button to create category' do
    expect(page).to have_button('Create category')
  end
  it 'have a input name' do
    expect(page).to have_css('input', id: 'category_name')
  end

  # it 'click to create category' do
  #   click_button 'button_category'
  #   expect(page).to have_selector('form',method: 'post', action: '/en/categories')
  # end
  # it 'should have a link to edit' do
  #   @categories.each do |category|
  #     expect(page).to have_link("/en/categories/#{ category.id }/edit")
  #   end
  # end
  # it 'have link to follow' do
  #   follow = FactoryBot.create(:follow)
  #   expect(page).to have_link ''
  # end
end

feature 'Create new category' do
  scenario 'with valid details' do
    visit '/en/categories/'
    click_button('#button_category')
    fill_in 'Name', with: 'New_Category_Name'
    click_button 'Create category'
    expect(rendered).to eq(new_category_path)
  end
end

# describe 'new category' do
#   it 'renders a form to create category' do
#     # assign(:category, double('Category'))
#     render
#     rendered.should have_selector('form',
#                                   :method => 'post',
#                                   :action => '/en/categories'
#                     ) do |form|
#       form.should have_selector('input', :type => 'submit')
#     end
#   end
# end



