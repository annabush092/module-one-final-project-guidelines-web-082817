class Turn < ActiveRecord::Base
  belongs_to :action
  belongs_to :player

  def self.run_turn(hash)
    Game.last.display_dashboard
    Turn.create(hash)
    Turn.last.display_actions_to_user
    Turn.last.player.choose_action
    Turn.last.action.occurs
  end

  def display_actions_to_user
    min_max = self.action.possible_points
    puts ""
    puts "It's #{self.player.name}'s turn."
    puts ""
    puts "Here are your possible actions:"
    puts "  -- study:        You"
    puts "                      Technical skills gain #{min_max.first}-#{min_max.last} points."
    puts "                      Wellbeing loses 0-2 points."
    puts "  -- pair_program: You and a Partner"
    puts "                      Technical skills gain 1-2 points."
    puts "                      Soft skills gain #{min_max.first}-#{min_max.last} points."
    puts "                      Wellbeing loses 0-1 points."
    puts "  -- sleep:        You"
    puts "                      Wellbeing gains 4-8 points."
    puts "  -- grab_drink:   You and a Partner"
    puts "                      Soft skills gain #{min_max.first}-#{min_max.last} points."
    puts "                      Wellbeing gains 1-2 points."
  end



end
