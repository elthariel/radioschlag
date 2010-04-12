class PlaylistAssignment < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :program
  set_primary_keys :program_id, :playlist_id

#  validates_presence_of :program_id, :playlist_id, :priority, :probability
  validates_presence_of :program_id, :playlist_id
end
