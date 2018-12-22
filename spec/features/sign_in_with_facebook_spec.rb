require 'rails_helper'
require 'spec_helper'
require 'support/omni_auth_test_helper'

RSpec.describe 'features/sign_in_with_facebook', type: :view do
  let(:images) { FactoryBot.create_list(:image, 5) }
  before do
    images
    valid_facebook_login_setup
    visit 'users/auth/facebook/callback'
    OmniAuth.config.mock_auth[:facebook]
  end

  it 'sign in with email' do
    expect(User.last.email).to eq('test@example.com')
  end

  it 'should redirect to root' do
    expect(response).to eq('')
  end

end
