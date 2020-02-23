require 'rails_helper'

feature 'user signs up', %Q{
  As a visitor
  I want to register
  So that I can create an account
} do

  # Acceptance Criteria
  # [ X ] I must specify a name
  # [ X ] I must specify a valid email and password
  # [ X ] If the information is invalid, I am presented with
        # an error message
  # [ X ] The password is not visible on the screen

  scenario 'visitor provides valid registration information' do
    visit new_user_registration_path

    fill_in 'Full Name', with: 'Naruto Uzumaki'
    fill_in 'Email', with: 'naruto@email.com'
    fill_in 'Password', with: 'banana'
    fill_in 'Password confirmation', with: 'banana'
    expect(page).to_not have_content('banana')

    click_button 'Sign up'

    expect(page).to have_content('Welcome! You have signed up successfully.')
  end

  scenario 'visitor provides invalid registration information' do
    visit new_user_registration_path
    click_button 'Sign up'

    expect(page).to have_content("Full name can't be blank")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content('Email is invalid')
    expect(page).to have_content("Password can't be blank")
    expect(page).to have_content("Encrypted password can't be blank")
  end
end
