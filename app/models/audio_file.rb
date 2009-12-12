class AudioFile < ActiveRecord::Base
  belongs_to :audio_file_type
  belongs_to :audio_file_style
  belongs_to :user
  # Using 'acts as list'
  has_many :audio_file_assignments
  has_many :playlists, :through => :audio_file_assignments

  validates_presence_of :path, :duration, :user_id
  validates_uniqueness_of :path
  validate :belong_to_an_user

  def belong_to_an_user
    errors.add("This file doesn't belong to an user") unless User.exists?(user_id)
  end
end
