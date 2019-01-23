class Game < ApplicationRecord
  has_many :game_cards
  has_many :cards, through: :game_cards
  has_many :participants
  has_many :users, through: :participant
  extend HistoryAPI
end
