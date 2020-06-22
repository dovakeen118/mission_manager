require "rails_helper"

RSpec.describe UserSerializer, type: :serializer do
  let!(:user) { FactoryBot.create(:user) }
  let!(:serializer) { UserSerializer.new(user) }
  let!(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }

  let!(:serialized_object) { JSON.parse(serialization.to_json) }

  it "returns the id that matches" do
    expect(serialized_object["user"]["id"]).to eq(user.id)
  end

  it "returns the email that matches" do
    expect(serialized_object["user"]["email"]).to eq(user.email)
  end

  it "returns the full name that matches" do
    expect(serialized_object["user"]["full_name"]).to eq(user.full_name)
  end

  it "returns the role that matches" do
    expect(serialized_object["user"]["role"]).to eq(user.role)
  end

  it "returns the profile image that matches" do
    image = JSON.parse(user.profile_image.to_json)

    expect(serialized_object["user"]["profile_image"]["url"]).to eq(image["url"])
  end

  it "returns all missions created by the user" do
    expect(serialized_object["user"]["missions"]).to eq(user.missions)
  end
end
