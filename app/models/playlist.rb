class Playlist < ActiveRecord::Base
  has_many :programs
  has_many :programs, :through => :playlist_assignments
  has_many :audio_file_assignments, :order => 'position'
  has_many :audio_files, :through => :audio_file_assignments
  has_many :type_style_assignments

  belongs_to :playlist_type
  belongs_to :playlist_player
  belongs_to :user

  validates_presence_of :name, :playlist_type_id, :playlist_player_id
  validate :validate_type_mode

  protected
  def validate_type_mode
    if playlist_type.name == 'typestyle' and playlist_player.name == 'order'
      errors.add_to_base("TypeStyle playlist could not be played in order, you should use 'random'")
    end
  end

end
