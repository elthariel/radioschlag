class PlaylistAssignment < ActiveRecord::Base
  has_one :playlist
  has_one :program

  validates_presence_of :program_id, :playlist_id, :priority, :probability
end
