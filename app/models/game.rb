class Game < ApplicationRecord
  has_many :cards
  has_many :users, through: :participant
end
