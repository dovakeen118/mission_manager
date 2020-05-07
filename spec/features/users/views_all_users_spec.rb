require 'rails_helper'

feature 'view list of all users', %Q{
  As a visitor
  I want to see a list
  So that I can see all the users
} do

  # Acceptance Criteria
  # [ x ] I do not need to be a registered user
  # [ x ] I can see the name of all users
  # [ x ] As a user I can see links to user profile pages
  # [ x ] As a user I can see the role of all users
  # [ ] As an admin user I can change user roles expect my own

  let!(:admin) { FactoryBot.create(:user, :admin) }
  let!(:user1) { FactoryBot.create(:user) }

  scenario 'visitor views all users' do
    visit users_path

    expect(page).to have_content('All Users (2)')
    expect(page).to have_content(admin.full_name)
    expect(page).to have_content(user1.full_name)

    expect(page).to_not have_content(admin.role)
    expect(page).to_not have_link(admin.full_name, href: user_path(admin))
    expect(page).to_not have_content(user1.role)
    expect(page).to_not have_link(user1.full_name, href: user_path(user1))
  end

  scenario 'user views all users' do
    login_as user1
    visit users_path

    expect(page).to have_content('All Users (2)')
    expect(page).to have_link(admin.full_name, href: user_path(admin))
    expect(page).to have_content(admin.role)

    expect(page).to have_link(user1.full_name, href: user_path(user1))
    expect(page).to have_content(user1.role)
  end

  scenario 'admin views all users' do
    login_as admin
    visit users_path

    expect(page).to have_content('All Users (2)')
    expect(page).to have_link(admin.full_name, href: user_path(admin))
    expect(page).to have_content(admin.role.titleize)

    expect(page).to have_link(user1.full_name, href: user_path(user1))
    expect(page).to have_content(user1.role.titleize)
  end

  scenario 'admin updates a user role' do
    login_as admin
    visit users_path

    user1_form = page.find_by_id("edit_user_#{user1.id}")
    within(user1_form) do
      select 'Admin', from: 'user[role]'
      click_button 'Change Role'
    end

    expect(page).to have_content('User was updated!')
  end
end
