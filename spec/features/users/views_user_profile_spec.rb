require 'rails_helper'

feature 'view a user profile page', %Q{
  As a user
  I can only view my profile page unless I am an admin
  So that user information is not shared
} do

  # Acceptance Criteria
  # [ x ] I must be signed in and authenticated
  # [ x ] I cannot view the profile page of a different user
  # [ x ] I can view my own profile page
  # [ x ] As an admin I can view any profile page

  let!(:admin) { FactoryBot.create(:user, :admin) }
  let!(:user1) { FactoryBot.create(:user) }
  let!(:user2) { FactoryBot.create(:user) }

  scenario 'visitor attempts to view a user profile page' do
    visit user_path(user1)

    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end

  scenario 'user attempts to view a different user profile page' do
    login_as user1
    visit user_path(user2)

    expect(page).to have_content('You are not authorized to view that page!')
  end

  scenario 'user attempts to view an admin profile page' do
    login_as user1
    visit user_path(admin)

    expect(page).to have_content('You are not authorized to view that page!')
  end

  scenario 'user views their own profile page' do
    login_as user1
    visit user_path(user1)

    expect(page).to have_link 'Back to all Users', href: users_path
    expect(page.find('img.profile-image')['src']).to have_content(user1.profile_image)
    expect(page).to have_content(user1.full_name)
    expect(page).to have_content(user1.email)
    expect(page).to have_content(user1.role)
  end

  scenario 'admin views a user profile page' do
    login_as admin
    visit user_path(user2)

    expect(page).to have_link 'Back to all Users', href: users_path
    expect(page.find('img.profile-image')['src']).to have_content(user2.profile_image)
    expect(page).to have_content(user2.full_name)
    expect(page).to have_content(user2.email)
    expect(page).to have_content(user2.role)
  end
end
