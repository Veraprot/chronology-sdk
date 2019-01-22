class AddAdminToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :admin, :integer
    change_column :participants, :score, :integer, default: 0
    change_column :participants, :num_of_answers, :integer, default: 0
    change_column :participants, :num_of_moves, :integer, default: 0
  end
end
