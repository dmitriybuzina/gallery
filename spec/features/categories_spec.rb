describe 'the signin process', type: :feature do
  describe 'on the index page' do
    before do
      @categories = []
      3.times{ @categories << FactoryBot.create(:category) }
      visit categories_path
    end
    it 'should list the categories name' do
      @categories.each do |category|
        expect(page).to have_content(category.name)
      end
    end
    it 'should have edit' do
      expect(page).to have_content('Edit')
    end
    it 'go to create category' do
      expect(page).to have_selector(:css, "p a#new_category_path")
    end
  end
end
describe 'creates category' do

end