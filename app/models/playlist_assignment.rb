class PlaylistAssignment < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :program

  validates_presence_of :program_id, :playlist_id, :priority, :probability
end
