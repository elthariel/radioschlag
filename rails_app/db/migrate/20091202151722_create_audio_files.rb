class CreateAudioFiles < ActiveRecord::Migration
  def self.up
    create_table :audio_files do |t|
      t.string :path
      t.integer :audio_file_style_id
      t.integer :audio_file_type_id
      t.integer :duration
      t.float :metric
      t.timestamps
    end
  end
  
  def self.down
    drop_table :audio_files
  end
end
