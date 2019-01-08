class Card < ApplicationRecord
  validates :date, uniqueness: true
end
