require 'rails_helper'

feature 'user edits account', %Q{
  As a registed user
  I want to edit my account
  So that I can update my information
} do

  # Acceptance Criteria
  # [ x ] I must be signed in and authenticated
  # [ x ] I can only edit my account information
  # [ x ] I must enter my current password to confirm the changes
  # [ x ] The password is not visible on the screen
  # [ ] I can update my existing account to link with my Facebook
  # [ ] I can update my existing account to unlink my Facebook

  let!(:user1) { FactoryBot.create(:user) }

  context 'user attempts to edit a different user' do
    scenario 'user is directed to their own account page' do
      user2 = FactoryBot.create(:user)
      login_as user2
      visit edit_user_registration_path(user1)

      expect(page).to have_content(user2.full_name)
    end
  end

  scenario 'user updates their account information' do
    login_as user1
    visit edit_user_registration_path(user1)
    expect(page).to have_content("Edit Account for #{user1.full_name}")

    fill_in 'Full Name', with: 'Sakura'
    fill_in 'Email', with: 'sakura@email.com'
    fill_in 'Current Password', with: 'banana'
    attach_file :user_profile_image, "#{Rails.root}/spec/support/images/photo.png"
    
    expect(page).to_not have_content('banana')
    click_button 'Update'

    expect(page).to have_content('Your account has been updated successfully.')
    expect(page).to have_content("Hi, Sakura")
  end
end
