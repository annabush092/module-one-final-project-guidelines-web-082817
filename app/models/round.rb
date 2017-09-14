class Round < ActiveRecord::Base

  belongs_to :event
  belongs_to :game

  def self.go_through_round(game_event_id_hash)
    round = Round.create(game_event_id_hash)
    #each round loops through one turn for every player
    round.game.players.each do |player|
      Game.last.display_dashboard
      Turn.run_turn({action_id: Action.create.id, player_id: player.id})
    end
    #each round ends with an event instance
    Game.last.display_dashboard
    event = Event.last
    event.update(action_type: Event.random_event_generator)
    event.occurs
  end

end
