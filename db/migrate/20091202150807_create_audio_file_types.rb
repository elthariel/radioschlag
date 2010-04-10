class CreateAudioFileTypes < ActiveRecord::Migration
  def self.up
    create_table :audio_file_types do |t|
      t.string :name
      t.text :desc
      t.float :metric
      t.timestamps
    end
  end
  
  def self.down
    drop_table :audio_file_types
  end
end
