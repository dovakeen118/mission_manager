require 'rails_helper'

RSpec.describe Mission, :type => :model do
  it { should belong_to(:user) }

  it { should have_valid(:title).when('Help', 'Save the cat!') }
  it { should_not have_valid(:title).when(nil, '') }

  it { should have_valid(:description).when('Help me', 'My cat is missing') }
  it { should_not have_valid(:description).when(nil, '') }
end
