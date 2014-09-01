class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.references :player_1
      t.references :player_2
      t.string :status
      t.references :winner

      t.timestamps
    end
    add_index :games, :player_1_id
    add_index :games, :player_2_id
    add_index :games, :winner_id
  end
end
