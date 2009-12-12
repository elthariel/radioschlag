class ProgramAssignments < ActiveRecord::Base
  attr_accessible :user_id, :program_id

  belongs_to :user
  belongs_to :program
end
