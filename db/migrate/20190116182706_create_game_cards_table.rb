class CreateGameCardsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :game_cards do |t|
      t.references :game, foreign_key: true
      t.references :card, foreign_key: true
    end
    remove_column :cards, :game_id
  end
end
