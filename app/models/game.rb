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
    puts ""
    name_array = []
    loop do
      print "Enter a name: "
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
    puts ""
  end

  def check_win_conditions
    #Game.last because otherwise we only see instances that haven't been updated
    Game.last.players.all? do |player|
      player.technical_skills >= 10 && player.soft_skills >= 10
    end
  end

  def play_game
    #loop through rounds
    while self.round <=5
      puts "******* ROUND #{self.round} *******"
      #iterate through each player's turns
      self.players.each do |player|
        Turn.run_turn({action_id: Action.create.id, player_id: player.id})
        break if self.check_win_conditions
      end
      self.increment!(:round, by = 1)
      break if self.check_win_conditions
    end
  end

  def print_welcome_message
    puts ""
    puts "*****************************************************************"
    puts "                WELCOME TO FLATIRON SCHOOL"
    puts "          You worked so hard to get here! But..."
    puts "            YOUR SKILLS ARE WOEFULLY INADEQUATE"
    puts ""
    puts "        In the next five rounds, you will have the"
    puts "      opportunity to improve. However, you'll soon"
    puts "      find that every hour spent studying yields less"
    puts "      and less improvement. Don't forget to take care"
    puts "      of yourself! And don't forget your new Flatiron"
    puts "      friends. You won't get far without their help...."
    puts ""
    puts "      To win:"
    puts "      EVERY player must earn 10 or more technical skill"
    puts "      points AND soft skill points before time runs out!"
    puts "      You have 5 rounds... GO!"
    puts "*****************************************************************"
    puts ""
  end

end
