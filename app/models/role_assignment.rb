class RoleAssignment < ActiveRecord::Base
  set_primary_key :user_id
  using_access_control

  belongs_to :user
  belongs_to :role

  validates_presence_of :user_id, :role_id
end
