module Actionable
#for events and actions

  def occurs
    change_hash = self.send(self.action_type)
    apply_point_changes(change_hash)
    print_changes(change_hash)
    #ensure that wellbeing never goes below 0 for any players
    Game.last.players.each do |player|
      player.check_wellbeing_min
    end
    check_win_conditions
    prompt_user_to_continue
    system "clear"
    # Game.last.display_dashboard
  end

  def apply_point_changes(changes_hash)
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

  def check_win_conditions
    #Game.last because otherwise we only see instances that haven't been updated
    result = Game.last.players.all? do |player|
      player.technical_skills >= 10 && player.soft_skills >= 10
    end
    if result
    #if true, end game
      puts "Congratulations, you won!"
      Game.last.update(win_loss: "win")
      Game.last.display_dashboard
      Game.save_game?
      Game.play_game
    end
  end

  def prompt_user_to_continue
    puts "Press enter to continue..."
    gets
  end

end
