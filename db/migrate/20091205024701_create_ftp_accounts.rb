class CreateFtpAccounts < ActiveRecord::Migration
  def self.up
    create_table :ftp_accounts do |t|
      t.integer :user_id
      t.integer :quota
      t.integer :sessions
    end
  end
  
  def self.down
    drop_table :ftp_accounts
  end
end
