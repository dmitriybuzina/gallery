require 'rails_helper'

RSpec.describe 'features/sign_in_with_facebook', type: :feature do
  before do
    visit user_session_path
  end

  scenario 'Sign in with facebook' do
    expect(page).to have_link'Sign in with Facebook'
    find_link('Sign in with Facebook').click
    sleep(10)
    fill_in 'email', with: 'dmytro.buzyna@gmail.com'
    fill_in 'pass', with: ''
    find('login').click
  end
end