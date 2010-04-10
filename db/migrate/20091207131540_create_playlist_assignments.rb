class CreatePlaylistAssignments < ActiveRecord::Migration
  def self.up
    create_table :playlist_assignments, :id => false do |t|
      t.integer :program_id
      t.integer :playlist_id
      t.integer :priority
      t.integer :probability
    end
  end

  def self.down
    drop_table :playlist_assignments
  end
end
