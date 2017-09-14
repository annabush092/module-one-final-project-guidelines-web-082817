class Game < ActiveRecord::Base
  has_many :players
  has_many :rounds
  has_many :events, through: :rounds
  has_many :turns, through: :players

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
    puts "******************* Round #{self.rounds.length} ******************* "
    puts ""
    puts "*************************************************************************"
    self.players.each do |player|
      print "Name: #{player.name} ** "
      print "Technical skills: #{player.technical_skills} ** "
      print "Soft skills: #{player.soft_skills} ** "
      puts "Wellbeing: #{player.wellbeing}"
    end
    puts "*************************************************************************"
    puts ""
  end

  def self.new_game?
    puts "Would you like to start a new game? y/n"
    response = gets.chomp
    if response == "n"
      puts "Thank you for playing!"
      exit
    elsif response == "y"
    else
      puts "I don't understand what you put."
      self.new_game?
    end
  end

  def self.save_game?
    puts "Would you like to save your game? y/n"
    response = gets.chomp
    if response == "n"
      puts "No problem, it's been erased from the universe."
      Game.last.destroy
    elsif response == "y"
      puts "Sure thing, your name is etched in the sands of time."
    else
      puts "I don't understand what you put."
      self.save_game?
    end
  end

  def self.play_game
    self.new_game?
    game = self.create
    #create player roster
    game.create_player_roster
    #loop through 5 rounds
    while Game.last.rounds.length < 5
      Round.go_through_round(game_id: game.id, event_id: Event.create.id)
    end
    #if you've made it this far, you lost
    Game.last.display_dashboard
    puts "You lost :("
    game.update(win_loss: "loss")
    self.save_game?
    #would you like to play again? (loop)
    self.play_game
  end

  def self.print_welcome_message
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
