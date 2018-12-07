require 'rails_helper'

describe 'the signin process', :type => :view do
  describe 'on the index page' do
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
      # find('#categories_modal')
      puts current_path
      expect(page).to have_selector('body > button > img')
      # expect(page).to have_css('a', href: 'New Category')
    end
    it 'should have link to category' do
      @categories.each do |category|
        expect(page).to have_link("/en/categories/#{ category.id }")
      end
    end
  end
end
