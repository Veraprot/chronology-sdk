class Game < ApplicationRecord
  has_many :cards
  has_many :participants
  has_many :users, through: :participant
  extend HistoryAPI
end
