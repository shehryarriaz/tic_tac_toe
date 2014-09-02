class Move < ActiveRecord::Base
  belongs_to :game
  belongs_to :user
  
  attr_accessible :marker, :space, :user_id, :game_id

  validate :game_is_active
  validate :is_player_turn
  validate :space_is_empty
  # validate :space_in_bounds

  # Checks if the current game is still in play via the Game status attribute. Game status should be changed in the Game model.
  private
  def game_is_active
    errors.add :game, "This game has ended." unless game.status == "in_progress"
  end

  private
  def is_player_turn
    errors.add :user, "It is not your turn." unless game.whose_turn == user
  end

  private
  def space_is_empty
    errors.add :space, "That space has been taken." unless game.taken_spaces.all? { |taken_space| taken_space != space }
  end

end
