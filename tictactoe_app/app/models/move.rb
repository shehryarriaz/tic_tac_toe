class Move < ActiveRecord::Base
  belongs_to :game
  belongs_to :user
  
  attr_accessible :marker, :space, :user_id, :game_id

  validate :game_is_active
  validate :is_player_turn
  validate :space_is_empty
  validate :space_in_bounds?

  after_create :change_game_status
  after_create :update_game_winner
  after_create :computer_player_turn

  private
  def game_is_active
    errors.add :base, "This game has ended." unless game.status == "In progress"
  end

  private
  def is_player_turn
    errors.add :base, "It's not your turn." unless game.whose_turn == user
  end

  private
  def space_is_empty
    errors.add :base, "That space has been taken." unless game.taken_spaces.all? { |taken_space| taken_space != space }
  end

  private
  def computer_player_turn
    if game.whose_turn.id == 3
      game.computer_turn
    end
  end

  private
  def change_game_status
    game.change_status
  end

  private
  def update_game_winner
    game.update_winner
  end

  private
  def space_in_bounds?
    errors.add :base, "That space is not in bounds." unless space >= 0 && space <= 8
  end

end