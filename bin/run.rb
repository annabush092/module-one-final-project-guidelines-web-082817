require_relative '../config/environment'

ActiveRecord::Base.logger = nil

# game = Game.create
# game.create_player_roster
#
5.times do
  Game.last.players.each do |player|
    Turn.run_turn({action_id: Action.create.id, player_id: player.id})
    break if Game.last.check_win_conditions
  end
  break if Game.last.check_win_conditions
  #can this be prettier?
end

puts "Congratulations! You've won!"


binding.pry

"k bye"
