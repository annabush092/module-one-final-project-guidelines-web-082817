require_relative '../config/environment'

ActiveRecord::Base.logger = nil

#create player roster
Game.create.create_player_roster
#go through gameplay
Game.play_game
#check for win
if Game.last.check_win_conditions
  puts "Congratulations! You've won!"
else
  puts "You lost :("
end



binding.pry

"k bye"
