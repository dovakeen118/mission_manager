class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :full_name, :role, :profile_image

  has_many :missions
end
