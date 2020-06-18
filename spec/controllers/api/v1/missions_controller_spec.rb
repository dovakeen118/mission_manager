require "rails_helper"

RSpec.describe Api::V1::MissionsController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }

  let!(:mission_object_1) { MissionSerializer.new(FactoryBot.create(:mission), scope: user, scope_name: :current_user) }
  let!(:mission_object_2) { MissionSerializer.new(FactoryBot.create(:mission), scope: user, scope_name: :current_user) }

  let(:mission_1) { JSON.parse(mission_object_1.to_json) }
  let(:mission_2) { JSON.parse(mission_object_2.to_json) }

  describe "POST#create" do
    context "successful request with proper params" do
      let!(:new_mission) {
        { mission:
          {
            title: "Save the cat",
            description: "Tora the cat is missing",
            user: user
          }
        }
      }

      it "persists the new mission to the database" do
        sign_in user
        previous_count = Mission.count
        post :create, params: new_mission, format: :json
        new_count = Mission.count

        expect(new_count).to eq(previous_count + 1)
      end

      it "returns the new mission as JSON" do
        sign_in user
        post :create, params: new_mission, format: :json
        response_body = JSON.parse(response.body)

        expect(response_body["mission"].length).to eq(6)
        expect(response_body["mission"]["title"]).to eq("Save the cat")
        expect(response_body["mission"]["description"]).to eq("Tora the cat is missing")
      end
    end

    context "unsuccessful request with malformed params" do
      let!(:bad_mission) {
        { mission:
          {
            title: "",
            description: "",
            user: user
          }
        }
      }

      it "does not persist to the database" do
        sign_in user
        previous_count = Mission.count
        post :create, params: bad_mission, format: :json
        new_count = Mission.count

        expect(new_count).to be(previous_count)
      end

      it "returns validation errors" do
        sign_in user
        post :create, params: bad_mission, format: :json
        response_body = JSON.parse(response.body)

        expect(response_body["errors"].include?("Title can't be blank")).to be(true)
        expect(response_body["errors"].include?("Description can't be blank")).to be(true)
      end

      it "returns invalid if a user is not signed in" do
        post :create, params: bad_mission, format: :json
        response_body = JSON.parse(response.body)

        expect(response_body["invalid"]).to eq(true)
      end
    end
  end

  describe "GET#index" do
    it "returns a successful response status and a content type of JSON" do
      sign_in user
      get :index

      expect(response.status).to eq(200)
      expect(response.content_type).to eq('application/json')
    end

    it "returns all serialized missions" do
      sign_in user
      get :index
      response_body = JSON.parse(response.body)

      expect(response_body["missions"].length).to eq(2)

      expect(response_body["missions"][0].length).to eq(6)
      expect(response_body["missions"][0]["id"]).to eq(mission_1["id"])
      expect(response_body["missions"][0]["title"]).to eq(mission_1["title"])
      expect(response_body["missions"][0]["description"]).to eq(mission_1["description"])
      expect(response_body["missions"][0]["created_at"]).to eq(mission_1["created_at"])
      expect(response_body["missions"][0]["session"]).to eq(mission_1["session"])
      expect(response_body["missions"][0]["user"]).to eq(mission_1["user"])

      expect(response_body["missions"][1].length).to eq(6)
      expect(response_body["missions"][1]["id"]).to eq(mission_2["id"])
      expect(response_body["missions"][1]["title"]).to eq(mission_2["title"])
      expect(response_body["missions"][1]["description"]).to eq(mission_2["description"])
      expect(response_body["missions"][1]["created_at"]).to eq(mission_2["created_at"])
      expect(response_body["missions"][1]["session"]).to eq(mission_2["session"])
      expect(response_body["missions"][1]["user"]).to eq(mission_2["user"])
    end
  end

  describe "GET#show" do
    it "returns a successful response status and a content type of JSON" do
      sign_in user
      get :show, params: { id: mission_1["id"] }

      expect(response.status).to eq(200)
      expect(response.content_type).to eq('application/json')
    end

    it "returns all information for the mission requested" do
      sign_in user
      get :show, params: { id: mission_1["id"] }
      response_body = JSON.parse(response.body)

      expect(response_body["mission"].length).to eq(6)
      expect(response_body["mission"]["id"]).to eq(mission_1["id"])
      expect(response_body["mission"]["title"]).to eq(mission_1["title"])
      expect(response_body["mission"]["description"]).to eq(mission_1["description"])
      expect(response_body["mission"]["created_at"]).to eq(mission_1["created_at"])
      expect(response_body["mission"]["session"]).to eq(mission_1["session"])
      expect(response_body["mission"]["user"]).to eq(mission_1["user"])
    end
  end
end
