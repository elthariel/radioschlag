class RoleAssignment < ActiveRecord::Base
  using_access_control

  validates_presence_of :user_id, :role_id
  belongs_to :user
  belongs_to :role
end
