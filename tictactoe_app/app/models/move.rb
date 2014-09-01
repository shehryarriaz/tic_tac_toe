class Move < ActiveRecord::Base
  belongs_to :game
  belongs_to :user
  
  attr_accessible :marker, :space
end
