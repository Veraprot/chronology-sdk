class User < ApplicationRecord
  has_secure_password
  has_many :games
  validates :email, uniqueness: true
  validates :username, uniqueness: true
end