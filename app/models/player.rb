class Player < ActiveRecord::Base
  has_many :turns
  has_many :actions, through: :turns
  belongs_to :game

  def initialize(player_hash)
    super
    self.knowledge = rand(0..5)
    self.social = rand(0..5)
    self.wellbeing = rand(0..5)
  end

end
