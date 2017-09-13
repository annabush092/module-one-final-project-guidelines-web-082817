require_relative '../../concerns/actionable.rb'
class Action < ActiveRecord::Base
  has_many :turns
  has_many :players, through: :turns

  include Actionable

  def current_player
    #private method for possible_points (via wellbeing_level)
    self.turns.last.player
  end

  def wellbeing_level
    # Private method for possible_points
    {"none" => 1, "low" => 3, "mid" => 6, "high" => 9, "awesome" => 100}.find do |word, num|
      current_player.wellbeing < num
    end[0] # => appropriate word
  end

  def possible_points
    min_max={"none" => [0,0], "low" => [0,2], "mid" => [1,3], "high" => [2,4], "awesome" => [3,5]}.find do |word, min_max|
      self.wellbeing_level == word
    end[1] # => [min, max]
    (min_max[0]..min_max[1])
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

  def sleep
    #make info hash to return
    {current_player.id.to_s =>
      {
      wellbeing: rand(4..8)
      }
    }
  end

  def partner_up(change_hash)
    #private method for actions requiring partners
    partner = current_player.random_player
    {current_player.id.to_s => change_hash,
      partner.id.to_s => change_hash}
  end

  def pair_program
    partner_up({
    technical_skills: rand(1..2),
    soft_skills: rand(possible_points),
    wellbeing: (rand(-1..0))
    })
  end

  def grab_drink
    partner_up({
      soft_skills: rand(possible_points),
      wellbeing: rand(1..2)
      })
  end

end
