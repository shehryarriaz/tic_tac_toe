### Game
Game player1:references player2:references status:integer winner:references
- has_many :moves
- belongs_to :player1, class: "User"
- belongs_to :player2, class: "User"