class Team < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  
  has_many :members,
    primary_key: :id,
    foreign_key: :team_id,
    class_name: :User

end
