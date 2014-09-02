<!-- Create new game -->
g = Game.new(player_1_id: 1, player_2_id: 2, status: "in_progress")

m1 = g.moves.new(user_id: 1, space: 0, marker: "o")
m2 = g.moves.new(user_id: 2, space: 1, marker: "x")