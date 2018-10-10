class UserAuthorizationToken < ApplicationRecord

  validates :token, presence: true

  belongs_to :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  # before validation creates a randomly generated string for the token
  before_validation :set_token

  def set_token
    self.token ||= SecureRandom.urlsafe_base64(16)
  end
  
end
