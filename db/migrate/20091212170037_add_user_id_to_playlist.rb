class AddUserIdToPlaylist < ActiveRecord::Migration
  def self.up
    add_column :playlists, :user_id, :integer, :null => false
  end

  def self.down
    remove_column :playlists, :user_id
  end
end
