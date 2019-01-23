class User < ApplicationRecord
  has_secure_password
  has_many :participants
  has_many :games, through: :participant
  validates :email, uniqueness: true
  validates :username, uniqueness: true
end