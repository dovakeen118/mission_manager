class MissionSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :created_at

  belongs_to :user

  def created_at
    "#{object.created_at.strftime("%B %e, %Y")}"
  end
end
