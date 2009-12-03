class CreateIncomingAudioFiles < ActiveRecord::Migration
  def self.up
    create_table :incoming_audio_files do |t|
      t.string :path
      t.integer :audio_file_type_id
      t.integer :audio_file_style_id
      t.timestamps
    end
  end
  
  def self.down
    drop_table :incoming_audio_files
  end
end
