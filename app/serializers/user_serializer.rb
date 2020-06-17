class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :full_name

  has_many :missions, each_serializer: MissionSerializer
end
