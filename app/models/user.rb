class User < ApplicationRecord
  EMAIL_REGEXP = /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable,
         :omniauth_providers => [:facebook]

  has_many :missions

  validates_presence_of :full_name, :encrypted_password
  validates :email, presence: true,
    format: EMAIL_REGEXP,
    uniqueness: true

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.full_name = data["name"] if user.full_name.blank?
        user.email = data["email"] if user.email.blank?
        user.provider = "facebook" if user.provider.blank?
        user.uid = data["id"] if user.uid.blank?
      end
    end
  end

  def self.from_facebook_omniauth(auth)
    where(provider: auth["provider"], uid: auth["uid"]).first_or_create do |user|
      user.full_name = auth["info"]["name"]
      user.email = auth["info"]["email"]
      user.password = Devise.friendly_token[0,20]
      user.provider = auth["provider"]
      user.uid = auth["uid"]
    end
  end
end
