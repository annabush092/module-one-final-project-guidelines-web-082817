class Game < ActiveRecord::Base
  has_many :players
  has_many :events
  has_many :turns, through: :players

  def initialize(attribute_hash)
    super
    self.community_points = 0
    self.round = 1
  end

  def get_players_from_user
    #private method used in create_player_roster
    #ask user for names, and returns an array of strings
    puts "Who wants to play? Type 'x' if you've entered everyone's name"
    puts "You must have more than one player."
    name_array = []
    loop do
      puts "Enter a name: "
      input = gets.chomp
      break if input == "x" unless name_array.length < 2
      name_array << input
    end


    name_array
  end

  def create_player_roster
    #takes an array of names and creates Player instances.
    #stores an array of Player instances
    self.get_players_from_user.each do |n|
      Player.create(name: n, game_id: self.id)
    end
  end


  def display_dashboard
    puts ""
    puts "********************************************************************"
    self.players.each do |player|
      print "Name: #{player.name} ** "
      print "Technical skills: #{player.technical_skills} ** "
      print "Soft skills: #{player.soft_skills} ** "
      puts "Wellbeing: #{player.wellbeing}"
    end
    puts "********************************************************************"
  end

  def check_win_conditions
    self.players.all? do |player|
      player.technical_skills >= 10 && player.soft_skills >= 10
    end
  end

  def self.play_game
    #loop through rounds
    while Game.last.round <=5
      puts "******* ROUND #{Game.last.round} *******"
      #iterate through each player's turns
      Game.last.players.each do |player|
        Turn.run_turn({action_id: Action.create.id, player_id: player.id})
        break if Game.last.check_win_conditions
      end
      Game.last.update(round: (Game.last.round + 1))
      break if Game.last.check_win_conditions
      #can this be prettier?
    end
  end

end
