class CreateRoleAssignments < ActiveRecord::Migration
  def self.up
    create_table :role_assignments, :id => false do |t|
      t.integer :user_id
      t.integer :role_id
    end

  end

  def self.down
    drop_table :role_assignments
  end
end
