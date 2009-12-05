class AddOwnerToAudioFiles < ActiveRecord::Migration
  def self.up
    add_column :audio_files, :user_id, :integer
    add_column :incoming_audio_files, :user_id, :integer
  end

  def self.down
    remove_column :audio_files, :user_id
    remove_column :incoming_audio_files, :user_id
  end
end
