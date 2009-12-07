class Slot < ActiveRecord::Base
  has_one :program

  validates_presence_of :name, :start, :end, :program_id
end
