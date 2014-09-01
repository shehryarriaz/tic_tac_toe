class CreateMoves < ActiveRecord::Migration
  def change
    create_table :moves do |t|
      t.references :game
      t.references :user
      t.integer :space
      t.string :marker

      t.timestamps
    end
    add_index :moves, :game_id
    add_index :moves, :user_id
  end
end
