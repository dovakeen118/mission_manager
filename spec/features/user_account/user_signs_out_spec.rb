require 'rails_helper'

feature 'user signs out', %Q{
  As a signed in user
  I want to sign out
  So that my identity is forgotten about on the machine I'm using
} do

  # Acceptance Criteria
  # [ X ] If I am signed in, I have the option to sign out
  # [ X ] When I opt to sign out, I get a confirmation that my identity has been
        # forgotten on the machine I am using

  scenario 'authenticated user signs out' do
    user = FactoryBot.create(:user)
    login_as user

    visit root_path
    click_on 'Sign out'

    expect(page).to have_content('Signed out successfully.')
  end
end
