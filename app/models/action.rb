class Action < ActiveRecord::Base
  has_many :turns
  has_many :players, through: :turns
end
