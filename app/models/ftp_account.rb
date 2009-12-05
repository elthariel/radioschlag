class FtpAccount < ActiveRecord::Base
  attr_accessible :user_id, :quota, :sessions
end
