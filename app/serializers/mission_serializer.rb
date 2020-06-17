class MissionSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :user
end
