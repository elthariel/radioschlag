class CreatePlaylistPlayers < ActiveRecord::Migration
  def self.up
    create_table :playlist_players do |t|
      t.string :name
      t.text :desc
    end
  end

  def self.down
    drop_table :playlist_players
  end
end
