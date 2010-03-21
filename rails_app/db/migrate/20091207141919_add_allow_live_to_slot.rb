class AddAllowLiveToSlot < ActiveRecord::Migration
  def self.up
    add_column :slots, :allow_live, :boolean, :default => false
  end

  def self.down
    remove_column :slots, :allow_live
  end
end
