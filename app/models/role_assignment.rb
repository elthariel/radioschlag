class RoleAssignment < ActiveRecord::Base
  using_access_control

  belongs_to :user
  belongs_to :role

  validates_presence_of :user_id, :role_id
end

