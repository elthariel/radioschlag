require 'sox/audio_file'

class AddMetadataToAudioFile < ActiveRecord::Migration
  def self.up
    add_column :audio_files, :title, :string, :default => "", :null => false
    add_column :audio_files, :artist, :string, :default  => "", :null => false
    add_column :audio_files, :album, :string, :default  => "", :null => false

    AudioFile.reset_column_information

    AudioFile.all.each do |f|
      puts "Processing file #{f.path}"
      comments = Sox::AudioFile.parse_vorbis_comments(f.path, true)

      f.title = comments['title'] if comments.has_key? 'title'
      f.artist = comments['artist'] if comments.has_key? 'artist'
      f.album = comments['album'] if comments.has_key? 'album'

      f.save
    end
  end

  def self.down
    remove_column :audio_files, :title
    remove_column :audio_files, :album
    remove_column :audio_files, :artist
  end
end
