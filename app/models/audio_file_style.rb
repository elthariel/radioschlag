class AudioFileStyle < ActiveRecord::Base
  attr_accessible :name, :desc, :metric
  has_many :audio_file

  validates_uniqueness_of :name
  validates_presence_of :name
  validates_length_of :name, :minimum => 3
end
