class User < ActiveRecord::Base
#  attr_accessible :username, :email, :password_protex, :phone, :profile
  acts_as_authentic
end
