require "rails_helper"

RSpec.describe Api::V1::UsersController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }
  let!(:mission) { FactoryBot.create(:mission, user: user) }

  let!(:user_object) { UserSerializer.new(user, scope: user, scope_name: :current_user) }
  let!(:user_1) { JSON.parse(user_object.to_json) }

  describe "GET#show" do
    it "returns a successful response status and a content type of JSON" do
      sign_in user
      get :show, params: { id: user_1["id"] }

      expect(response.status).to eq(200)
      expect(response.content_type).to eq('application/json')
    end

    it "returns all information for the user requested" do
      sign_in user
      get :show, params: { id: user_1["id"] }

      response_body = JSON.parse(response.body)
      mission_response = response_body["user"]["missions"]

      expect(response_body["user"].length).to eq(6)
      expect(response_body["user"]["email"]).to eq(user_1["email"])
      expect(response_body["user"]["full_name"]).to eq(user_1["full_name"])
      expect(response_body["user"]["role"]).to eq(user_1["role"])
      expect(response_body["user"]["profile_image"]["url"]).to eq(user_1["profile_image"]["url"])

      expect(mission_response.length).to eq(user_1["missions"].length)
      expect(mission_response[0]["id"]).to eq(user_1["missions"][0]["id"])
      expect(mission_response[0]["title"]).to eq(user_1["missions"][0]["title"])
      expect(mission_response[0]["description"]).to eq(user_1["missions"][0]["description"])
      expect(mission_response[0]["created_at"]).to eq(user_1["missions"][0]["created_at"])
    end
  end
end
