class User < ActiveRecord::Base
  has_secure_password

  has_many :games_as_player1, class_name: "Game", foreign_key: :player_1_id
  has_many :games_as_player2, class_name: "Game", foreign_key: :player_2_id
  has_many :moves

  attr_accessible :email, :name, :password, :password_confirmation
  
  validates :password, presence: true, on: :create
  validates :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }

  def games
    Game.where("games.player_1_id = :id or games.player_2_id = :id", id: id )
  end

  def wins
    Game.where(winner_id: id).count
  end

  def losses
    self.games.where("status = 'finished' and winner_id != :id", id: id).count
  end

  def draws
    self.games.where(winner_id: nil).where(status: "finished").count
  end

  def in_progress
    self.games.where(status: "in_progress").count
  end

  def win_loss
    (self.wins.to_f / self.losses.to_f).round(2)
  end

end
