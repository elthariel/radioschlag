class PlaylistPlayer < ActiveRecord::Base
  attr_accessible :name, :desc

  validates_presence_of :name
end
