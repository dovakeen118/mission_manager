require "rails_helper"

RSpec.describe UserSerializer, type: :serializer do
  let!(:user) { FactoryBot.create(:user) }
  let!(:serializer) { UserSerializer.new(user) }
  let!(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }

  let!(:serialized_object) { JSON.parse(serialization.to_json) }

  it "returns an id that matches" do
    expect(serialized_object["user"]["id"]).to eq(user.id)
  end

  it "returns an email that matches" do
    expect(serialized_object["user"]["email"]).to eq(user.email)
  end

  it "returns a full name that matches" do
    expect(serialized_object["user"]["full_name"]).to eq(user.full_name)
  end

  it "returns a role that matches" do
    expect(serialized_object["user"]["role"]).to eq(user.role)
  end

  it "returns all missions created by the user" do
    expect(serialized_object["user"]["missions"]).to eq(user.missions)
  end
end
