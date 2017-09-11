class Turn < ActiveRecord::Base
  belongs_to :action
  belongs_to :player
end
