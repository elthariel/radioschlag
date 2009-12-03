class AudioFile < ActiveRecord::Base
  attr_accessible :path, :audio_file_style_id, :audio_file_type_id, :duration, :metric
  belongs_to :audio_file_type
  belongs_to :audio_file_style

  validates_presence_of :path, :duration
  validates_uniqueness_of :path
end
