class AudioFile < ActiveRecord::Base
  attr_accessible :path, :audio_file_style_id, :audio_file_type_id, :duration, :metric
end
