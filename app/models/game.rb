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
    name_array = []
    loop do
      input = gets.chomp
      break if input == "x"
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


end
