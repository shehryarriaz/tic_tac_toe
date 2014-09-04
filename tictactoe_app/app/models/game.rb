class Game < ActiveRecord::Base
  belongs_to :player_1, class_name: "User"
  belongs_to :player_2, class_name: "User"
  belongs_to :winner, class_name: "User"
  has_many :moves

  attr_accessible :status, :player_1_id, :player_2_id

  validates :player_1, presence: true
  validates :player_2, presence: true
  validate :different_players

  before_create :set_in_progress

  def different_players
    errors.add :base, "You can't play against yourself." unless player_2 != player_1
  end

  def player_1_moves
    self.player_1.moves.where(game_id: id)
  end

  def player_2_moves
    self.player_2.moves.where(game_id: id)
  end

  def board
    board = [nil, nil, nil, nil, nil, nil, nil, nil, nil]
    moves.each { |move| board[move.space] = move.marker }
    board
  end

  def next_marker
    moves.last.try(:marker) == 'O' ? 'X' : 'O'
  end

  def game_won?
    win_conditions = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    win_conditions.detect do |condition|
      line = condition.map { |index| board[index] }
      line.any? && line.uniq.count == 1
    end
  end

  def game_drawn?
    self.moves.count >= 9 && !game_won?
  end

  def active?
    !game_won? && !game_drawn?
  end

  def change_status
    reload
    if game_won? || game_drawn?
      self.status = "Finished"
      self.save!
    end
  end

  def update_winner
    if game_won? && !game_drawn?
      self.winner = self.moves.sort.last.user
      self.save!
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

  def computer_turn
    reload
    if player_2_id == 1 && self.active?
      board_spaces = [ 0, 1, 2, 3, 4, 5, 6, 7, 8]
      free_spaces = board_spaces - self.taken_spaces
      move_space = free_spaces.sample
      move = self.moves.new(user_id: 1, space: move_space, marker: self.next_marker)
      move.save!
    end
  end

  private
  def set_in_progress
    self.status ||= "In progress"
  end
  
end