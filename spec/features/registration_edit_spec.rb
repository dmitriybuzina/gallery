require 'rails_helper'

describe 'Settings', type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:images) { FactoryBot.create_list(:image, 5) }
  before do
    images
    login_as user, scope: :user
    visit edit_user_registration_path
  end

  it 'have h1 Profile' do
    expect(page).to have_css('h1', text: 'Profile')
  end

  it 'have input for user avatar' do
    expect(page).to have_css('input', id: 'user_avatar')
  end

  it 'have input email' do
    expect(page).to have_css('input', id: 'user_email')
  end

  it 'have input name' do
    expect(page).to have_css('input', id: 'user_first_name')
  end

  it 'have input surname' do
    expect(page).to have_css('input', id: 'user_last_name')
  end

  it 'have input phone' do
    expect(page).to have_css('input', id: 'user_phone')
  end

  it 'have input date of birthday' do
    expect(page).to have_css('input', id: 'user_date_of_birthday')
  end

  it 'have input location' do
    expect(page).to have_css('input', id: 'user_location')
  end

  it 'have input password' do
    expect(page).to have_css('input', id: 'user_password')
  end

  it 'have input password confirmation' do
    expect(page).to have_css('input', id: 'user_password_confirmation')
  end

  it 'have input current password' do
    expect(page).to have_css('input', id: 'user_current_password')
  end

  it 'have link for cancel account' do
    expect(page).to have_link('Cancel my account')
  end

  it 'have button update' do
    expect(page).to have_xpath("//input[contains(@value, 'Update')]")
  end

  scenario 'save phone for user' do
    fill_in 'user_phone', with: '0954121212'
    fill_in 'user_password', with: ''
    fill_in 'user_current_password', with: user.password
    find(:xpath, "//input[contains(@value, 'Update')]").click
    expect(User.last.phone).to eq '0954121212'
  end

  scenario 'save location for user' do
    fill_in 'user_location', with: 'Kyiv'
    fill_in 'user_password', with: ''
    fill_in 'user_current_password', with: user.password
    find(:xpath, "//input[contains(@value, 'Update')]").click
    expect(User.last.location).to eq 'Kyiv'
  end

  context 'invalid password' do
    scenario 'not save location for user' do
      fill_in 'user_location', with: 'Kyiv'
      fill_in 'user_password', with: ''
      fill_in 'user_current_password', with: '121212121212'
      find(:xpath, "//input[contains(@value, 'Update')]").click
      expect(User.last.location == 'Kyiv').to eq false
      expect(page).to have_content('Current password is invalid')
    end
  end

end