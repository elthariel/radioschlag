class Playlist < ActiveRecord::Base
  has_many :playlist_assignments
  has_many :programs, :through => :playlist_assignments
  has_many :audio_file_assignments, :order => 'position'
  has_many :audio_files, :through => :audio_file_assignments

  belongs_to :playlist_type
  belongs_to :playlist_player
  belongs_to :user

  validates_presence_of :name, :playlist_type_id, :playlist_player_id
end
