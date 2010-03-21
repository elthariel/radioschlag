class TypeStyleAssignment < ActiveRecord::Base
  belongs_to :audio_file_type
  belongs_to :audio_file_style
  belongs_to :playlist
end
