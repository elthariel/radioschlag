class AudioFileAssignment < ActiveRecord::Base
  belongs_to :audio_file
  belongs_to :playlist
  acts_as_list :scope => :playlist
end
