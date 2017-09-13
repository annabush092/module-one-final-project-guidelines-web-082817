require_relative '../../concerns/actionable.rb'

class Event < ActiveRecord::Base
  has_many :rounds
  has_many :games, through: :rounds

  include Actionable

  def self.random_event_generator
    #returns a string of a random event
    ["blizzard", "start_new_module", "flu_season", "broken_coffee_machine", "power_outage", "raccoon_loose_in_flatiron", "thanksgiving_break", "job_fair", "flatiron_rearranges_space", "happy_hour", "shaw_presents_a_blog", "successful_review_session"].sample
  end



  def event_display(string)
    puts "***   ***   ***   ***   ***   ***   ***   ***   ***   ***   ***  ***"
    puts "********************************************************************"
    puts string
    puts "********************************************************************"
    puts "***   ***   ***   ***   ***   ***   ***   ***   ***   ***   ***  ***"
  end

  # flu season --> one player loses all wellbeing
  def flu_season
    event_display("It's flu season!\n One player has been infected and needs some time to recuperate.")
    {Game.last.players.sample.id.to_s =>
      {wellbeing: -100}
    }
  end


  def group_event_hash_creator(changes_hash)
    Game.last.players.map do |p|
      [p.id.to_s,
        changes_hash
      ]
    end.to_h
  end

  # blizzard --> everyone's soft skills drop 2 points, wellbeing improves 1 point
  def blizzard
    event_display("New York had a huge blizzard!\n All players stayed home and enjoyed the rest.")
    group_event_hash_creator({soft_skills: -2, wellbeing: 1})
  end

  # start a new module --> everyone's technical_skills drop 1 point
  def start_new_module
    event_display("Your class started a new module!\n All the new material is so overwhelming...\n Will you ever learn it all?")
    group_event_hash_creator({technical_skills: -1})
  end


  # coffee machine breaks --> everyone's wellbeing and soft_skills loses 1 point
  def broken_coffee_machine
    event_display("The coffee-maker broke!\n All students are feeling grumpy and tired.")
    group_event_hash_creator({wellbeing: -1, soft_skills: -1})
  end

  # power outage --> everyone's technical_skills drop 1 point
  def power_outage
    event_display("There has been a city-wide power outage!\n All the computers are down- no studying for today!")
    group_event_hash_creator({technical_skills: -1})
  end

  # raccoon loose in flatiron --> everyone's technical_skills drop 2 point and wellbeing drops 1 points
  def raccoon_loose_in_flatiron
    event_display("A raccoon has gotten loose in Flatiron!\n Equipment and health are both at risk from this wild creature.")
    group_event_hash_creator({technical_skills: -2, wellbeing: -1})
  end

  # thanksgiving --> everyone's technical skills drop 2 points, wellbeing rises 3 points
  def thanksgiving_break
    event_display("It's Thanksgiving break!\n Go home and enjoy your time off...\n But don't let too much knowledge leak from your brains!")
    group_event_hash_creator({technical_skills: -2, wellbeing: 3})
  end

  # job fair --> everyone's soft skills improve 3 points
  def job_fair
    event_display("Flatiron holds a JOB FAIR. Everyone busts out their business cards.")
    group_event_hash_creator({soft_skills: 3})
  end

  # flatiron rearranges space --> everyone's wellbeing improves 2 points
  def flatiron_rearranges_space
    event_display("FLATIRON REARRANGES THE TABLES, so we all have a bit more space!")
    group_event_hash_creator({wellbeing: 2})
  end


  # happy hour --> everyone's wellbeing, soft_skills improves 2 points
  def happy_hour
    event_display("It's HAPPY HOUR! Everybody let's loose.")
    group_event_hash_creator({soft_skills: 2, wellbeing: 2})
  end

  # Shaw presents a blog --> everyone's technical_skills improves 1 point
  def shaw_presents_a_blog
    event_display("SHAW PRESENTS A BLOG -- everyone learns a lot.")
    group_event_hash_creator({technical_skills: 1})
  end

  # TA's hold successful review session --> everyone's technical_skills improves 2 point
  def successful_review_session
    event_display("The T.A.'s hold a GREAT REVIEW SESSION!")
    group_event_hash_creator({technical_skills: 2})
  end



end
