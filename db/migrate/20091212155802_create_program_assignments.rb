class CreateProgramAssignments < ActiveRecord::Migration
  def self.up
    create_table :program_assignments do |t|
      t.integer :user_id
      t.integer :program_id
    end
  end

  def self.down
    drop_table :program_assignments
  end
end
