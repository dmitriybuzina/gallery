require 'rails_helper'

describe 'the signup process', type: :feature do
  let(:images) { FactoryBot.create_list(:image, 5) }
  context 'user sign up' do
    before do
      images
      visit new_user_registration_path
      within('form') do
        fill_in 'user_email', with: 'user@example.com'
        fill_in 'user_first_name', with: 'John'
        fill_in 'user_last_name', with: 'Smith'
        fill_in 'user_password', with: '123456'
        fill_in 'user_password_confirmation', with: '123456'
      end
      click_button 'Sign up'
    end
    it 'signs me up' do
      expect(page).to have_no_content 'Log in'
    end
  end

  context 'email exist' do
    before do
      FactoryBot.create(:user, email: 'user@example.com')
      visit new_user_registration_path
      within('form') do
        fill_in 'user_email', with: 'user@example.com'
        fill_in 'user_first_name', with: 'John'
        fill_in 'user_last_name', with: 'Smith'
        fill_in 'user_password', with: '123456'
        fill_in 'user_password_confirmation', with: '123456'
      end
      click_button 'Sign up'
    end
    it 'not sign me up' do
      expect(page).to have_content('Email has already been taken')
    end
  end

  context 'wrong password confirmation' do
    before do
      visit new_user_registration_path
      within('form') do
        fill_in 'user_email', with: 'user@example.com'
        fill_in 'user_first_name', with: 'John'
        fill_in 'user_last_name', with: 'Smith'
        fill_in 'user_password', with: '123456'
        fill_in 'user_password_confirmation', with: '1234567'
      end
      click_button 'Sign up'
    end
    it 'not sign me up' do
      expect(page).to have_content("Password confirmation doesn't match Password")
    end
  end
end

describe 'the signin process', type: :feature do
  let(:images) { FactoryBot.create_list(:image, 5) }
  before :each do
    FactoryBot.create(:user, email: 'user@example.com', password: 'password')
    visit user_session_path
  end
  it 'have h1 Sign in' do
    expect(page).to have_css('h1', text: 'Sign in')
  end
  it 'have input email' do
    expect(page).to have_css('input', id: 'user_email')
  end
  it 'have input password' do
    expect(page).to have_css('input', id: 'user_password')
  end
  it 'signs me in' do
    images
    within('form') do
      fill_in 'user_email', with: 'user@example.com'
      fill_in 'user_password', with: 'password'
    end
    click_button 'Sign in'
    expect(page).to have_no_content 'Log in'
  end

  it 'sign in as another user' do
    within('form') do
      fill_in 'user_email', with: 'other@example.com'
      fill_in 'user_password', with: 'rous'
    end
    click_button 'Sign in'
    expect(page).to have_content 'Sign in'
  end
  # it 'capture should appear' do
  #   3.times do
  #     fill_in 'user_email', with: 'other@example.com'
  #     fill_in 'user_password', with: 'rous'
  #   end
  #   expect(page).to have_css('label', text: "I'm not a robot")
  # end
end
