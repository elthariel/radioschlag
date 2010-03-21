class CreatePlaylists < ActiveRecord::Migration
  def self.up
    create_table :playlists do |t|
      t.string :name
      t.text :desc
      t.integer :playlist_type_id
      t.integer :playlist_player_id
      t.text :content
      t.timestamps
    end
  end
  
  def self.down
    drop_table :playlists
  end
end
