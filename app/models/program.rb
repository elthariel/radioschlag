class Program < ActiveRecord::Base
  has_many :playlist_assignments
  has_many :playlists, :through => :playlist_assignments

  attr_accessible :name, :desc
end
