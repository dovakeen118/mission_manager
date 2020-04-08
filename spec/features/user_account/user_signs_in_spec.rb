require 'rails_helper'

feature 'user signs in', %Q{
  As a registered user
  I want to sign in
  So that I can access my account
} do

  # Acceptance Criteria
  # [ X ] Only authenticated users can sign in
  # [ X ] I must specify an email and password found in the system
  # [ X ] If the provided email and password is found in the system, authenticate
  # [ X ] If the provided email and password is not found in the system,
        # deny access and display an error message
  # [ X ] The password is not visible on the screen

  let!(:user) { FactoryBot.create(:user) }

  scenario 'valid account' do
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    expect(page).to_not have_content(user.password)
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully.')
    expect(page).to have_content(user.full_name)
  end

  scenario 'invalid account' do
    visit new_user_session_path
    click_button 'Log in'

    expect(page).to have_content('Invalid Email or password.')
  end

  scenario 'is already signed in' do
    visit new_user_session_path
    login_as user

    visit new_user_session_path
    expect(page).to have_content('You are already signed in.')
  end
end
