class UpdateProgramPlaylistRelation < ActiveRecord::Migration
  
  def self.up
    add_column :programs, :playlist_id, :integer, :default => Playlist.first.id, :null => false
    
    Program.reset_column_information
    
    Program.all.each do |x|
      if x.playlists.first
        x.playlist_id = x.playlists.first.id
        x.save
      end
    end
    
    drop_table :playlist_assignments
  end

  def self.down
    remove_column :programs, :playlist_id
    
    create_table "playlist_assignments", :id => false, :force => true do |t|
      t.integer "program_id"
      t.integer "playlist_id"
      t.integer "priority"
      t.integer "probability"
    end
  end
end
