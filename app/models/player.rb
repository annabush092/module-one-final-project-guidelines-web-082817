class Player < ActiveRecord::Base
  has_many :turns
  has_many :actions, through: :turns
  belongs_to :game

  def initialize(player_hash)
    super
    self.technical_skills = rand(0..5)
    self.soft_skills = rand(0..5)
    self.wellbeing = rand(0..5)
  end

  def choose_action
    print "What would you like to do? "
    #get input from user and check if it is valid
    action_string = gets.chomp
    while !Action.instance_methods.any? {|m| m == action_string.to_sym}
      puts "Invalid entry. Please choose a listed action."
      action_string = gets.chomp
    end
    #find and update the newly-created, blank action instance with action_type
    self.turns.last.action.update(action_type: action_string)
  end

  def random_player
    our_players = self.game.players
    random_player = our_players.sample
    while random_player.id == self.id
      random_player = our_players.sample
    end
    random_player
  end

  def update_points(hash)
    hash.each do |attribute, point_change|
      # self.update(attribute => (self.send(attribute.to_s) + point_change))
      self.increment!(attribute, by = point_change)
    end
  end

  def check_wellbeing_min
    self.update(wellbeing: 0) if self.wellbeing < 0
  end

end
