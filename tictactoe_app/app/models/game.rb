class Game < ActiveRecord::Base
  belongs_to :player_1, class_name: "User"
  belongs_to :player_2, class_name: "User"
  belongs_to :winner, class_name: "User"
  has_many :moves

  attr_accessible :status, :player_1_id, :player_2_id

  
end
