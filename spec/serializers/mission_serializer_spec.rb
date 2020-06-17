require "rails_helper"

RSpec.describe MissionSerializer, type: :serializer do
  let!(:mission) { FactoryBot.create(:mission) }
  let!(:serializer) { MissionSerializer.new(mission) }
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
end
