class Program < ActiveRecord::Base
  has_many :playlist_assignments
  has_many :playlists, :through => :playlist_assignments
  has_many :program_assignments
  has_many :programs, :through => :program_assignments
end
