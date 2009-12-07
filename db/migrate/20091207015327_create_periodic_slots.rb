class CreatePeriodicSlots < ActiveRecord::Migration
  def self.up
    create_table :periodic_slots do |t|
      t.string :name
      t.text :desc
      t.integer :start
      t.integer :end
      t.integer :program_id
      t.timestamps
    end
  end
  
  def self.down
    drop_table :periodic_slots
  end
end
