class FtpAccount < ActiveRecord::Base
  using_access_control

  belongs_to :user

  validates_presence_of :user_id, :quota, :sessions

end
