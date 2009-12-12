class ProgramAssignment < ActiveRecord::Base
  using_access_control

  belongs_to :user
  belongs_to :program
end
