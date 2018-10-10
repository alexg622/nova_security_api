class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true

  belongs_to :team,
    primary_key: :id,
    foreign_key: :team_id,
    class_name: :Team,
    optional: true

  has_one :auth_token,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :UserAuthorizationToken

  # after user saves makes a new token object for that use
  after_save :make_token

  def show_token
    self.auth_token.token
  end

  def make_token
    token = UserAuthorizationToken.new(user_id: self.id)
    token.save
  end
  
end
