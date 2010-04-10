class Slot < ActiveRecord::Base
  belongs_to :program

  validates_presence_of :name, :start, :end, :program_id
  validates_numericality_of :start, :less_than_or_equal_to => 7 * 24 * 60
  validates_numericality_of :end, :less_than_or_equal_to => 7 * 24 * 60
  validate :start_before_end

  def start_before_end
    errors.add "Start must be before the end" unless start < self.end
  end
end
