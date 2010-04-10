class CreateAudioFileAssignments < ActiveRecord::Migration
  def self.up
    create_table :audio_file_assignments do |t|
      t.integer :playlist_id
      t.integer :audio_file_id
      t.integer :position
      t.timestamps
    end
  end
  
  def self.down
    drop_table :audio_file_assignments
  end
end
