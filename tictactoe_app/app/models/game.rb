class Game < ActiveRecord::Base
  belongs_to :player_1, class_name: "User"
  belongs_to :player_2, class_name: "User"
  belongs_to :winner, class_name: "User"
  has_many :moves

  attr_accessible :status, :player_1_id, :player_2_id

  before_save :set_in_progress, on: :create

  def make_move(user_id, space, marker)
    move = self.moves.create(user_id: user_id, space: space, marker: marker )
    move.save
  end

  def player_1_moves
    self.player_1.moves.where(game_id: id)
  end

  def player_2_moves
    self.player_2.moves.where(game_id: id)
  end

  def game_won?
    win_conditions = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    win_conditions.detect do |condition|
      line = condition.map { |index| board[index] }
      line.any? && line.uniq.count == 1
    end
  end

  def game_drawn?
    self.moves.count >= 9 || !game_won?
  end

  def board
    board = [nil, nil, nil, nil, nil, nil, nil, nil, nil]
    moves.each { |move| board[move.space] = move.marker }
    board
  end

  def active?
    !game_won? && !game_drawn?
  end

  def change_status
    if game_won? || game_drawn?
      self.status = "finished"
    end
  end

  def whose_turn
    moves.count.even? ? player_1 : player_2
  end

  def taken_spaces
    taken_spaces = []
    self.moves.each { |move| taken_spaces << move.space }
    return taken_spaces
  end

  private
  def set_in_progress
    self.status = "in_progress"
  end
  
end
