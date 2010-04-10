class AddUserIdToPlaylist < ActiveRecord::Migration
  def self.up
    add_column :playlists, :user_id, :integer, :null => false, :default => 1
  end

  def self.down
    remove_column :playlists, :user_id
  end
end
