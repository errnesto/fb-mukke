class ChangeUidFormatInUsers < ActiveRecord::Migration
  def up
   remove_column :users, :uid
   change_table :users do |t|
  		t.integer :uid, :limit => 8
	end
  end

  def down
   remove_column :users, :uid
   add_column :users, :uid, :int
  end
end
