class Program < ActiveRecord::Base
#  attr_accessible :name, :desc

  belongs_to :playlist
  has_many :program_assignments
  has_many :users, :through => :program_assignments
  has_many :slots
end

