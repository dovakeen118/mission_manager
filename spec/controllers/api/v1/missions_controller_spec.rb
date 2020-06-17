require "rails_helper"

RSpec.describe Api::V1::MissionsController, type: :controller do
  let!(:mission_1) { FactoryBot.create(:mission) }
  let!(:mission_2) { FactoryBot.create(:mission) }

  describe "GET#index" do
    it "returns a successful response status and a content type of JSON" do
      get :index

      expect(response.status).to eq(200)
      expect(response.content_type).to eq('application/json')
    end

    it "returns all serialized missions" do
      get :index
      response_body = JSON.parse(response.body)

      expect(response_body["missions"].length).to eq(2)

      expect(response_body["missions"][0]["title"]).to eq(mission_1.title)
      expect(response_body["missions"][0]["description"]).to eq(mission_1.description)
      expect(response_body["missions"][0]["created_at"]).to eq(mission_1.created_at.strftime("%B %e, %Y"))
      expect(response_body["missions"][0]["user"]).to eq(UserSerializer.new(mission_1.user).attributes.stringify_keys)

      expect(response_body["missions"][1]["title"]).to eq(mission_2.title)
      expect(response_body["missions"][1]["description"]).to eq(mission_2.description)
      expect(response_body["missions"][1]["created_at"]).to eq(mission_2.created_at.strftime("%B %e, %Y"))
      expect(response_body["missions"][1]["user"]).to eq(UserSerializer.new(mission_2.user).attributes.stringify_keys)
    end
  end

  describe "GET#show" do
    it "returns a successful response status and a content type of JSON" do
      get :show, params: { id: mission_1.id }

      expect(response.status).to eq(200)
      expect(response.content_type).to eq('application/json')
    end

    it "returns all information for the mission requested" do
      get :show, params: { id: mission_1.id }
      response_body = JSON.parse(response.body)

      expect(response_body["mission"].length).to eq(5)

      expect(response_body["mission"]["title"]).to eq(mission_1.title)
      expect(response_body["mission"]["description"]).to eq(mission_1.description)
      expect(response_body["mission"]["created_at"]).to eq(mission_1.created_at.strftime("%B %e, %Y"))
      expect(response_body["mission"]["user"]).to eq(UserSerializer.new(mission_1.user).attributes.stringify_keys)
    end
  end
end
