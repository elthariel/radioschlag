class IncomingAudioFile < ActiveRecord::Base
  attr_accessible :path, :audio_file_type_id, :audio_file_style_id
  belongs_to :audio_file_type
  belongs_to :audio_file_style

  validates_presence_of :path
  validates_uniqueness_of :path
end
