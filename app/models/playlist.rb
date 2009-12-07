class Playlist < ActiveRecord::Base
  has_many :playlist_assignments
  has_many :programs, :through => :playlist_assignments
  has_one :playlist_type
  has_one :playlist_player

  validates_presence_of :name, :playlist_type_id, :playlist_player_id
end
