class CreateCardTable < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.integer :date
      t.string :event

      t.timestamps
    end
  end
end
