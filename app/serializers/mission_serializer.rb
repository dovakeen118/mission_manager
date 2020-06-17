class MissionSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :created_timestamp

  belongs_to :user

  def created_timestamp
    "#{object.created_at.strftime("%B %e, %Y")}"
  end
end
