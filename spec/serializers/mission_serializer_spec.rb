require "rails_helper"

RSpec.describe MissionSerializer, type: :serializer do
  let!(:user) { FactoryBot.create(:user)}
  let!(:mission) { FactoryBot.create(:mission) }
  let!(:serializer) { MissionSerializer.new(mission, scope: user, scope_name: :current_user) }
  let!(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }

  let!(:serialized_object) { JSON.parse(serialization.to_json) }

  it "returns an id that matches" do
    expect(serialized_object["mission"]["id"]).to eq(mission.id)
  end

  it "returns a title that matches" do
    expect(serialized_object["mission"]["title"]).to eq(mission.title)
  end

  it "returns a description that matches" do
    expect(serialized_object["mission"]["description"]).to eq(mission.description)
  end

  it "returns a created_at timestamp that matches and is formatted" do
    expect(serialized_object["mission"]["created_at"]).to eq(mission.created_at.strftime("%B %e, %Y"))
  end

  it "returns the serialized user that matches" do
    expect(serialized_object["mission"]["user"]).to eq(UserSerializer.new(mission.user).attributes.stringify_keys)
  end

  it "returns a boolean if a user is signed in" do
    expect(serialized_object["mission"]["session"]).to eq(true)
  end
end
