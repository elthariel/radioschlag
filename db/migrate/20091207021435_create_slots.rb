class CreateSlots < ActiveRecord::Migration
  def self.up
    create_table :slots do |t|
      t.string :name
      t.text :desc
      t.integer :start
      t.integer :end
      t.integer :program_id
      t.timestamps
    end
  end
  
  def self.down
    drop_table :slots
  end
end
