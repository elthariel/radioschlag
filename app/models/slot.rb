class Slot < ActiveRecord::Base
  attr_accessible :name, :desc, :start, :end, :program_id
end
