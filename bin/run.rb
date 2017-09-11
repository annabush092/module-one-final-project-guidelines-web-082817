require_relative '../config/environment'

game = Game.create
game.reset_community_points_and_round
game.create_player_roster

binding.pry
