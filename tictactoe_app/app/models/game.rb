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

  def game_won?
    #Add method here
  end

  def game_drawn?
    moves.count == 9 && !game_won?
  end

  def active?
    !game_won? && !game_drawn?
  end

  def change_status
    unless self.active?
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
