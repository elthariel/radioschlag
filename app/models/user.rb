class User < ActiveRecord::Base
  # AuthLogic user model
  acts_as_authentic

  has_many :incoming_audio_file
  has_many :audio_file
  has_many :role_assignments
  has_many :roles, :through => :role_assignments

  def role_symbols
    roles.map do |r|
      r.name.underscore.to_sym
    end
  end
end
