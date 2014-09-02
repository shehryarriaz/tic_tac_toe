class Move < ActiveRecord::Base
  belongs_to :game
  belongs_to :user
  
  attr_accessible :marker, :space

  validate :is_player_turn

  # Checks if player making the current move ALSO made the last move
  private
  def is_player_turn
    errors.add :base, "It is not your turn" unless game.whos_turn == user
  end

end
