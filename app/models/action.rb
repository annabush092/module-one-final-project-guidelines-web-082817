class Action < ActiveRecord::Base
  has_many :turns
  has_many :players, through: :turns

  def occurs
    change_hash = self.send(self.action_type)
    update_points(change_hash)
    print_changes(change_hash)
    current_player.check_wellbeing_min
  end

  def current_player
    self.turns.last.player
  end

  def possible_points
    if current_player.wellbeing == 0
      min_gain = 0
      max_gain = 0
    elsif current_player.wellbeing < 3
      min_gain = 0
      max_gain = 2
    elsif current_player.wellbeing < 6
      min_gain = 1
      max_gain = 3
    elsif current_player.wellbeing < 9
      min_gain = 2
      max_gain = 4
    else
      min_gain = 3
      max_gain = 5
    end
    min_gain..max_gain
  end

  def update_points(changes_hash)
    #update points
    changes_hash.each do |player, point_changes|
      player_to_update = Player.find(player.to_i)
      player_to_update.update_points(point_changes)
    end
  end

  def print_changes(changes_hash)
    puts ""
    changes_hash.each do |player_id, point_changes|
      point_changes.each do |attribute, change|
        a = attribute.to_s.split("_").join(" ")
        puts "#{Player.find(player_id.to_i).name} changed his/her #{a} by #{change} points."
      end
    end
    puts ""
  end

  def study
    #make info hash to return
    {current_player.id.to_s =>
      {
      technical_skills: rand(possible_points),
      wellbeing: rand(-2..-1)
      }
    }
  end

  def pair_program
    #get partner
    partner = current_player.random_player
    #make info hash to return
    {current_player.id.to_s =>
      {
      technical_skills: rand(1..2),
      soft_skills: rand(possible_points)
      },
    partner.id.to_s =>
      {
      technical_skills: rand(1..2),
      soft_skills: rand(possible_points)
      }
    }
  end

  def sleep
    #make info hash to return
    {current_player.id.to_s =>
      {
      wellbeing: rand(4..8)
      }
    }
  end

  def grab_drink
    #get partner
    partner = current_player.random_player
    #make info hash to return
    {current_player.id.to_s =>
      {
      soft_skills: rand(possible_points),
      wellbeing: rand(1..2)
      },
    partner.id.to_s =>
      {
      soft_skills: rand(possible_points),
      wellbeing: rand(1..2)
      }
    }
  end

end
