class AddGameIdToCards < ActiveRecord::Migration[5.2]
  def change
    add_reference :cards, :game, index: true
    add_column :participants, :num_of_answers, :integer
    add_column :participants, :num_of_moves, :integer
  end
end
