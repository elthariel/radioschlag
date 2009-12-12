class SwitchPlaylistToActaslist < ActiveRecord::Migration
  def self.up
    remove_column :playlists, :content
  end

  def self.down
    add_column :playlists, :content, :text
  end
end
