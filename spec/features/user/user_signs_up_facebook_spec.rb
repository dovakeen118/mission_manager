require 'rails_helper'

feature 'user signs up with facebook', %Q{
  As a visitor
  I want to register through Facebook
  So that I can create an account
} do

  # Acceptance Criteria
  # [ X ] I must have a Facebook account
  # [ X ] Facebook account must have a name and email address
  # [ ] User can update their existing account to link with their Facebook

  let!(:login_form) { LoginForm.new }

  scenario 'visitor not previoulsy registered' do
    login_form.visit_page.mock_auth_hash.social_login("facebook")

    expect(page).to have_content("Successfully authenticated from Facebook account.")
  end

  scenario 'visitor previously registered through Devise' do
    user = FactoryBot.create(:user)
    login_form.visit_page.mock_auth_hash(user.email).social_login("facebook")

    expect(page).to have_content("Successfully authenticated from Facebook account.")
  end
end
