class CreateFtpAccounts < ActiveRecord::Migration
  def self.up
    create_table :ftp_accounts do |t|
      t.integer :user_id
      t.integer :quota
      t.integer :sessions, :default => 3
    end

    add_column :users, :ftp_account_id, :integer, :default => 0
  end

  def self.down
    drop_table :ftp_accounts

    drop_column :users, :ftp_account_id
  end
end
