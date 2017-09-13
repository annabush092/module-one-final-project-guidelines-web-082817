require_relative '../config/environment'

ActiveRecord::Base.logger = nil

Game.find_by(win_loss: nil).destroy
# Game.destroy_all
# Player.destroy_all
# Turn.destroy_all
# Action.destroy_all

Game.print_welcome_message
Game.play_game


binding.pry

"k bye"
