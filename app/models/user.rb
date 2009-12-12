class User < ActiveRecord::Base
  # AuthLogic user model
  acts_as_authentic

  has_many :incoming_audio_files
  has_many :audio_files
  has_many :playlists
  has_many :role_assignments
  has_many :roles, :through => :role_assignments
  has_many :program_assignments
  has_many :programs, :through => :program_assignments
  has_one :ftp_account
  accepts_nested_attributes_for :ftp_account, :allow_destroy => true

  def role_symbols
    roles.map do |r|
      r.name.underscore.to_sym
    end
  end
end
