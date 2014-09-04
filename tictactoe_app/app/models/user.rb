class User < ActiveRecord::Base
  has_secure_password

  has_many :games_as_player1, class_name: "Game", foreign_key: :player_1_id
  has_many :games_as_player2, class_name: "Game", foreign_key: :player_2_id
  has_many :moves

  attr_accessible :email, :name, :password, :password_confirmation
  
  validates :password, presence: true, on: :create
  validates :email, presence: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+.)+[a-z]{2,})\Z/i, on: :create
  validates :email, uniqueness: { case_sensitive: false }

  before_create :default_role

  def role?(role_to_compare)
    self.role.to_s == role_to_compare.to_s
  end

  def games
    Game.where("games.player_1_id = :id or games.player_2_id = :id", id: id )
  end

  def wins
    Game.where(winner_id: id).count
  end

  def losses
    self.games.where("status = 'Finished' and winner_id != :id", id: id).count
  end

  def draws
    self.games.where(winner_id: nil).where(status: "Finished").count
  end

  def in_progress
    self.games.where(status: "In Progress").count
  end

  def win_loss
    if self.wins == 0 && self.losses
      "N/A"
    else
    (self.wins.to_f / (self.wins.to_f + self.losses.to_f)).round(2)
    end
  end

  private
  def default_role
    self.role ||= :basic_user
  end

end
