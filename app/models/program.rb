class Program < ActiveRecord::Base
#  attr_accessible :name, :desc

  has_many :playlist_assignments
  has_many :playlists, :through => :playlist_assignments
  has_many :program_assignments
  has_many :users, :through => :program_assignments
end

