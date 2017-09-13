require_relative '../config/environment'

ActiveRecord::Base.logger = nil
#
# Game.destroy_all
# Player.destroy_all
# Turn.destroy_all
# Action.destroy_all



#create player roster
game = Game.create
game.print_welcome_message
game.create_player_roster
#go through gameplay
game.play_game
#check for win
if game.check_win_conditions
  puts "Congratulations! You've won!"
  game.update(win_loss: "won")
else
  puts "You lost :("
  game.update(win_loss: "loss")
end



binding.pry

"k bye"
