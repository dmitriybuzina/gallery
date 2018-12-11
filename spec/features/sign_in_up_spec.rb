describe 'the signup process', type: :feature do
  before :each do
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
    expect(page).to have_content 'Log out'
  end
end

describe 'the signin process', type: :feature do
  before :each do
    User.create(email: 'user@example.com', password: 'password')
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
    within('form') do
      fill_in 'user_email', with: 'user@example.com'
      fill_in 'user_password', with: 'password'
    end
    click_button 'Sign in'
    expect(page).to have_content 'Log out'
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
