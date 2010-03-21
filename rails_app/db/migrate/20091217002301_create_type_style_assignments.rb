class CreateTypeStyleAssignments < ActiveRecord::Migration
  def self.up
    create_table :type_style_assignments do |t|
      t.integer :audio_file_type_id
      t.integer :audio_file_style_id
      t.integer :playlist_id
      t.float :metric, :default => 1.0
      t.timestamps
    end
  end

  def self.down
    drop_table :type_style_assignments
  end
end
