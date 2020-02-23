require 'rails_helper'

RSpec.describe User, :type => :model do
  it { should have_many :missions }

  it { should have_valid(:full_name).when('Naruto', 'Sakura') }
  it { should_not have_valid(:full_name).when(nil, '') }

  it { should have_valid(:email).when('naruto@example.com', 's123@email.com') }
  it { should_not have_valid(:email).when(nil, '', 'bad', '.com', 'bad@com', 'bad.com') }

  it 'requires a unique email' do
    user = FactoryBot.create(:user)
    other_user = FactoryBot.create(:user)

    user.email = other_user.email

    expect(user).to_not be_valid
    expect(user.errors[:email]).to_not be_blank
  end
end
