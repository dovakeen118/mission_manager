require 'rails_helper'

RSpec.describe User, :type => :model do
  it { should have_many(:missions) }

  it { should have_valid(:full_name).when('Naruto', 'Sakura') }
  it { should_not have_valid(:full_name).when(nil, '') }

  it { should have_valid(:email).when('naruto@example.com', 's123@email.com') }
  it { should_not have_valid(:email).when(nil, '', 'bad', '.com', 'bad@com', 'bad.com') }

  it { should have_valid(:role).when(0, 1) }
  it { should_not have_valid(:role).when(nil, '') }

  it { is_expected.to callback(:set_default_role).after(:initialize) }

  it 'requires a unique email' do
    user = FactoryBot.create(:user)
    other_user = FactoryBot.create(:user)

    user.email = other_user.email

    expect(user).to_not be_valid
    expect(user.errors[:email]).to_not be_blank
  end

  it "should throw an error with an invalid role" do
    expect { User.create(full_name: 'Naruto', email: 'n@example.com', role: 4) }.to raise_error(ArgumentError)
    expect { User.create(full_name: 'Sakura', email: 's@example.com', role: "something") }.to raise_error(ArgumentError)
    expect(User.create(full_name: 'Kakashi', email: 'k@example.com', role: nil)).not_to be_valid
  end

  it "should have an enum on role that returns the correct string" do
    naruto = User.create(full_name: 'Naruto', email: 'n@example.com', role: 0)
    sakura = User.create(full_name: 'Sakura', email: 's@example.com', role: 1)

    expect(naruto.role).to eq "user"
    expect(sakura.role).to eq "admin"
  end

  describe "#set_default_role" do
    it "should set default role to 'user'" do
      naruto = User.create(full_name: 'Naruto', email: 'n@example.com')

      expect(naruto.role).to eq "user"
    end
  end
end
